; ******************************************************************
; Init (program start)
; ******************************************************************

Init:
    INCLUDE splash/splash_init.X68

    ; Load pallette
    lea     Palette, a0                                         ; Load pallete adress
    move.w  #$01, d0                                            ; 1 palette
    move.l  #$00, d1                                            ; No offset
    jsr     LoadPalette
    
    ; Load character tiles
    lea     TileCharacters, a0                                  ; Load tiles
    move.w  #$45, d0                                            ; $45 tiles
    move.l  #$00, d1                                            ; No offset
    jsr     LoadTile

    ; Render test string
    lea     TEST, a0                                            ; Load terst address into a0
    move.w  #$0501, d0                                          ; Get position (5, 1) coords
    jsr     TileXY                                              ; Get coords
    move.l  #$0000, d0                                          ; Set tile offset to $00000000
    move.l  #$0000, d2                                          ; Set default pallette
    jsr     ASCIIString                                         ; Render string
    
    ; Test sprite
    lea     TestSprite, a0                                      ; Load address of test sprite
    move.w  #01, d0                                             ; 1 Sprite
    move.l  #00, d1                                             ; No offset
    jsr     LoadSprite

    ; Test movement of sprite
    move.w  #$00, d0                                            ; Select sprite 0
    move.w  #$B0, d1                                            ; X coord
    jsr     SetSpritePosX                                       ; Set X pos
    move.w  #$B0, d1                                            ; Y coord
    jsr     SetSpritePosY                                       ; Set Y pos
    
*    ; Put test coords on stack
*    move.w  #$B0, -(a7)                                         ; Put Y on stack
*    move.w  #$B0, -(a7)                                         ; Put X on stack

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
