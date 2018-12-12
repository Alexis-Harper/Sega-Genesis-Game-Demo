; ******************************************************************
; VDP Subroutines
; ******************************************************************

LoadPalette: ; d0 palletes, d1 offset, a0 address
    mulu.w  #$20, d1                                            ; Multiply by $10 to convert offset to bytes
    swap    d1                                                  ; Swap words
    add.l   #$C0000003, d1                                      ; Add offset to control                      
    move.l  d1, VDP_CONTROL                                     ; Setup VDP write to CRAM
    mulu    #$08, d0                                            ; Multiply palette number by $10 (colors in a palette)
    subq.w  #$01, d0                                            ; Subtract by 1

.loop
    move.l  (a0)+, VDP_DATA                                     ; Write palette color
    dbra    d0, .loop                                           ; Check the counter
    rts
    
LoadTile: ; d0 tiles, d1 offset, a0 address
    swap    d1                                                  ; Swap words
    add.l   #VDP_VRAM_WRITE, d1                                 ; Add offset to control
    move.l  d1, VDP_CONTROL                                     ; Set up VDP write to VRAM
    
    mulu    #$20, d0                                            ; Multiply number of pallettes by $20 (bytes in a tile
    sub.w   #$01, d0                                            ; Subtract by 1
    
.loop
    move.l  (a0)+, VDP_DATA                                     ; Write tile line
    dbra    d0, .loop                                           ; Check the counter
    rts
    
LoadTileset: ; d0 base tile, d1 rows & columns, d2 initial VRAM write address, a0 address of tileset
    
    
TileXY: ; d0 XY coord
    clr.l   d1                                                  ; Clear d3
    move.b  d0, d1                                              ; Move Y coord to d1
    mulu.w  #$0040, d1                                          ; Multiply Y by $0040 (width of screen)
    ror.l   #$08, d0                                            ; Move lower byte to base
    add.b   d0, d1                                              ; Add lower byte of X to Y offset
    mulu.w  #$0002, d1                                          ; Convert to word (?)
    swap    d1                                                  ; Swap words (necessary for addresses to work)
    rts

ASCIIString: ; d0 tile ID, d1 tile coord, d2 pallette, a0 string address
    add.l   #VDP_VRAM_WRITE_A, d1                               ; Add base to tile coord
    move.l  d1, VDP_CONTROL                                     ; Send to VDP data
    
    move.b  d2, d3                                              ; Move pallette ID
    rol.l   #$08, d3                                            ; Roll #$0D times
    rol.l   #$05, d3                                            ; (Only $08 per roll)
    
    lea     ASCIIMap, a1                                        ; Load cases to a1
    
.char_loop
    clr.l   d2                                                  ; Clear register
    move.b  (a0)+, d2                                           ; Get character in string
    
    cmpi.b  #$00, d2                                            ; Check if zero
    beq     .end                                                ; End if null terminator
    
    sub.b   #$20, d2                                            ; Subtract by $20 (start code)
    move.b  (a1, d2.w), d3                                      ; Get tile ID from map
    add.w   d0, d3                                              ; Add tile offset
    
    move.l  d3, VDP_DATA                                        ; Send character to VDP_DATA
    
    bra     .char_loop                                          ; Loop until done
    
.end
    rts
    
ASCIIMap:
    dc.b    $00 ; SPACE (ASCII code $20)
    dc.b    $01 ; ! Exclamation mark
    dc.b    $02 ; " Double quotes
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $03 ; ' Single quote
    dc.b    $04 ; ( Open parenthesis
    dc.b    $05 ; ) Close parenthesis
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $06 ; , Comma
    dc.b    $00 ; UNUSED
    dc.b    $07 ; . Full stop
    dc.b    $00 ; UNUSED
    dc.b    $08 ; 0 Zero
    dc.b    $09 ; 1 One
    dc.b    $0A ; 2 Two
    dc.b    $0B ; 3 Three
    dc.b    $0C ; 4 Four
    dc.b    $0D ; 5 Five
    dc.b    $0E ; 6 Six
    dc.b    $0F ; 7 Seven
    dc.b    $10 ; 8 Eight
    dc.b    $11 ; 9 Nine
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $12 ; ? Question mark
    dc.b    $00 ; UNUSED
    dc.b    $13 ; A
    dc.b    $14 ; B
    dc.b    $15 ; C
    dc.b    $16 ; D
    dc.b    $17 ; E
    dc.b    $18 ; F
    dc.b    $19 ; G
    dc.b    $1A ; H
    dc.b    $1B ; I
    dc.b    $1C ; J
    dc.b    $1D ; K
    dc.b    $1E ; L
    dc.b    $1F ; M
    dc.b    $20 ; N
    dc.b    $21 ; O
    dc.b    $22 ; P
    dc.b    $23 ; Q
    dc.b    $24 ; R
    dc.b    $25 ; S
    dc.b    $26 ; T
    dc.b    $27 ; U
    dc.b    $28 ; V
    dc.b    $29 ; W
    dc.b    $2A ; X
    dc.b    $2B ; Y
    dc.b    $2C ; Z  
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $00 ; UNUSED
    dc.b    $2D ; a
    dc.b    $2E ; b
    dc.b    $2F ; c
    dc.b    $30 ; d
    dc.b    $31 ; e
    dc.b    $32 ; f
    dc.b    $33 ; g
    dc.b    $34 ; h
    dc.b    $35 ; i
    dc.b    $36 ; j
    dc.b    $37 ; k
    dc.b    $38 ; l
    dc.b    $39 ; m
    dc.b    $3A ; n
    dc.b    $3B ; o
    dc.b    $3C ; p
    dc.b    $3D ; q
    dc.b    $3E ; r
    dc.b    $3F ; s
    dc.b    $40 ; t
    dc.b    $41 ; u
    dc.b    $42 ; v
    dc.b    $43 ; w
    dc.b    $44 ; x
    dc.b    $45 ; y
    dc.b    $46 ; z  

TEST:
    dc.b    'TEST', $00 ; TEST string




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
