; ******************************************************************
; Main Loop
; ******************************************************************

MainLoop:

    jsr     ReadJoypads                                         ; Read joypads
    
*    ; Move player
*    move.w  (a7)+, d2                                           ; Get Y from stack
*    move.w  (a7)+, d1                                           ; Get X from stack
*    
*    btst    #BUTTON_UP_PRESSED, d0                              ; Check if up was pressed
*    bne     .noUP                                               ; Branch if up isn't pressed
*    addq.w  #$01, d2                                            ; Add Y position
*.noUP
*    btst    #BUTTON_RIGHT_PRESSED, d0                           ; Check if right was pressed
*    bne     .noRIGHT                                            ; Branch if right isn't pressed
*    addq.w  #$01, d1                                            ; Add X position
*.noRIGHT
*    btst    #BUTTON_DOWN_PRESSED, d0                            ; Check if up was pressed
*    bne     .noDOWN                                             ; Branch if up isn't pressed
*    subq.w  #$01, d2                                            ; Sub Y position
*.noDOWN
*    btst    #BUTTON_LEFT_PRESSED, d0                            ; Check if up was pressed
*    bne     .noLEFT                                             ; Branch if up isn't pressed
*    subq.w  #$01, d1                                            ; Sub X position
*.noLEFT

    ; VBlanks
    jsr     WaitVBlankStart                                     ; Wait until VBlank
    
*    ; Change player position
*    move.l  #00, d0                                             ; Affect sprite $00
*    jsr     SetSpritePosX                                       ; Change X position
*    move.w  d1, -(a7)                                           ; Push X to stack
*    
*    move.w  d2, d1                                              ; Set it to Y
*    jsr     SetSpritePosY                                       ; Change Y position
*    move.w  d1, -(a7)                                           ; Push Y to stack
    
    ; VBlank end
    jsr     WaitVBlankEnd                                       ; Wait until VBlank ends

    jmp     MainLoop                                            ; Loop

WaitVBlankStart: ; Wait until vertical trace
    move.w  VDP_CONTROL, d0                                     ; Get VDP status
    andi.w  #$0008, d0                                          ; AND with bit 4 (vblank), result in status register
    bne     WaitVBlankStart                                     ; Repeat if not ready
    rts
    
WaitVBlankEnd: ; Wait until vertical trace ends
    move.w  VDP_CONTROL, d0                                     ; Get VDP status
    andi.w  #$0008, d0                                          ; AND with bit 4 (vblank), result in status register
    beq     WaitVBlankEnd                                       ; Repeat if not ready
    rts

WaitFrames: ; d0 frames to wait
    move.l  V_INTERUPT_COUNTER, d1                              ; Get frames

.wait
    move.l  V_INTERUPT_COUNTER, d2                              ; Get frames
    subx.l  d1, d2                                              ; Get delta
    cmp.l   d0, d2                                              ; Compare frames
    blt     .wait                                               ; Loop if not done
    rts

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
