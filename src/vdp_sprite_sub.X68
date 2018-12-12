; ******************************************************************
; VDP Sprite Subroutines
; ******************************************************************

LoadSprite: ; d0 sprites, d1 offset, a0 address
    mulu.w  #$08, d1                                            ; Multiply offset by $08 due to sprite lenth
    swap    d1                                                  ; Move to upper word
    add.l   #VDP_VRAM_WRITE_SPRITE, d1                          ; Add adress to control
    move.l  d1, VDP_CONTROL                                     ; Set it to sprite
    subq.w  #$01, d0                                            ; Subtract 1 from counter (?)
    
.loop
    move.l  (a0)+, VDP_DATA                                     ; Move first long word
    move.l  (a0)+, VDP_DATA                                     ; Move second long word
    dbra    d0, .loop                                           ; Check counter
    rts
    
SetSpritePosX: ; d0 sprite, d1 X pos
    clr.l   d3                                                  ; Clear d3
    move.b  d0, d3                                              ; Move sprite ID to d3
    mulu.w  #$08, d3                                            ; Sprite size
    addq.b  #$06, d3                                            ; Add X offset location
    swap    d3                                                  ; Move to upper word
    add.l   #$60000003, d3                                      ; Add control
    move.l  d3, VDP_CONTROL                                     ; Send control statement
    move.w  d1, VDP_DATA                                        ; Send data
    rts
    
SetSpritePosY: ; d0 sprite, d1 X pos
    clr.l   d3                                                  ; Clear d3
    move.b  d0, d3                                              ; Move sprite ID to d3
    mulu.w  #$08, d3                                            ; Sprite size
    swap    d3                                                  ; Move to upper word
    add.l   #$60000003, d3                                      ; Add control
    move.l  d3, VDP_CONTROL                                     ; Send control statement
    move.w  d1, VDP_DATA                                        ; Send data
    rts
    
    
SetSpriteNext: ; d0 sprite, d1 next sprite
    clr.l   d3                                                  ; Clear d3
    move.b  d0, d3                                              ; Move sprite ID to d3
    mulu.w  #$08, d3                                            ; Sprite size
    addq.b  #03, d3                                             ; Next offset

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
