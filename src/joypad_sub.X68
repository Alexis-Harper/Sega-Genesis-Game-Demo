; ******************************************************************
; Joypad Subroutines
; ******************************************************************

ReadJoypads:
    lea     CTRL_1_DATA, a0                                     ; Load address to read controller 1 data
    lea     MEM_CONTROL_HELD, a1                                ; Load address to write results of the read
    bsr.s   ReadJoypad                                          ; read first joypad 
    ;addq.w  #2,a0                                               ; Switch to second joypad data
    ;bsr.s   ReadJoypad                                          ; Read second joypad
    rts

ReadJoypad:
    move.b  #0, (a0)                                            ; Read joypad data port
    nop                                                         ; Bus synchronization
    nop                                                         ; Bus synchronization
    move.b  (a0), d1                                            ; Get joypad data - Start/A
    lsl.w   #2, d1                                              ; Shift them so they are at the 2 highest bits
    move.b  #$40, (a0)                                          ; Read joypad data port again
    nop                                                         ; Bus synchronization
    nop                                                         ; Bus synchronization
    move.b  (a0), d0                                            ; Get joypad data - C/B/Dpad
    andi.b  #$3F, d0                                            ; C/B/Dpad in low 6 bits
    andi.b  #$C0, d1                                            ; Start/A in high 2 bits
    or.b    d1, d0                                              ; Merge values from both registers
    not.b   d0                                                  ; Revert bits so '0' means not pressed, and '1' pressed
    move.b  (a1), d1                                            ; Get previous joypad state
    eor.b   d0, d1                                              ; Toggle off buttons that are being held
    move.b  d0, (a1)+                                           ; 'joypad held' functionality 
    and.b   d0, d1
    move.b  d1, (a1)+                                           ; 'joypad pressed' functionality
    rts

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
