; ******************************************************************
; Entry Point (hardware reset & initialization)
; ******************************************************************


EntryPoint:
    tst.w   $00A10008                                           ; Mystery reset
    bne     Init
    tst.w   $00A1000C                                           ; See if reset button is pressed
    bne     Init

ClearRAM:
    move.l  #$00000000, d0                                      ; Move $00000000 into d0
    move.l  d0, a0                                              ; Start a0 at nothing (to roll-over)
    move.l  #$00003FFF, d1                                      ; Set counter to $3FFF
.loop
    move.l  d0, -(a0)                                           ; Reset address pointed by a0
    dbra    d1, .loop                                           ; Check the counter

    ; If V2, load SEGA string into adress (piracy protection)
    move.b  $A10001, d0
    andi.b  #$0F, d0
    beq.b   .version_0
    move.l  'SEGA', $A14000
.version_0:

    move.w  #$0100, Z80_BUS                                     ; Request access to Z80
    move.w  #$0100, Z80_RESET                                   ; Hold Z80 in RESET state
.z80_wait
    btst    #$00, Z80_BUS                                       ; Check if we can access Z80
    bne     .z80_wait

    lea     Z80Data, a0                                         ; Load adress of Z80 program to a0
    lea     Z80_ADRESS, a1                                      ; Copy Z80 adress
    move.l  #$29,d0                                             ; $29 bytes of data (minus one for the counter)
.copy_z80
    move.b  (a0)+, (a1)+                                        ; Copy data
    dbra    d0, .copy_z80

    move.w  #$0000, Z80_RESET                                   ; Un-reset Z80
    move.w  #$0000, Z80_BUS                                     ; Release control of Z80

    ; Initialize PSG (Programmabe Sound Generator)
    lea     PSGData, a0                                         ; Load PSG data address
    move.l  #$03, d0                                            ; 4 bytes of data (minus one for the counter)
.copy_psg
    move.b  (a0)+, (PSG_INPUT)                                  ; Copy data to PSG RAM
    dbra    d0, .copy_psg

    ; Initialise VDP registers
    lea     VDPRegisters, a0                                    ; Load adress of registers to a0
    move.l  #$00000018, d0                                      ; $18 registers to write
    move.l  #$00008000, d1                                      ; Set register 0 command
.copy_vdp
    move.w  (a0)+, d1                                           ; Move register to lower part of d1
    move.w  d1, VDP_CONTROL                                     ; Write command to VDP
    add.w   #$0100, d1                                          ; Increment command register number
    dbra    d0, .copy_vdp

    ; Initialize controller ports
    move.b  #$00, CTRL_1_CONTROL                                ; Set controller port 1 to IN

    ; Initialize registers
    move.l  #$00000000, a0                                      ; Move $00 to a0
    move.l  #$00000000, (a0)                                    ; Make sure that (a0) is $00
    movem.l (a0), d1-d7/a1-a6                                   ; Move 0 to all registers
    lea     $01000000, a7                                       ; Move $01000000 to stack pointer

    ; Init status register (no trace, supervisor mode, all interrupt levels enabled, clear condition code bits)
    move    #$2000, sr


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
