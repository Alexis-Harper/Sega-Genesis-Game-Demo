; ******************************************************************
; Exceptions & Interupts
; ******************************************************************

VBlankInterrupt:
    addq.l  #$01, V_INTERUPT_COUNTER                            ; Increment hinterrupt counter
    rte

HBlankInterrupt:
    addq.l  #$01, H_INTERUPT_COUNTER                            ; Increment hinterrupt counter
    rte

Exception:
    rts                                                         ; Return from Exception



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
