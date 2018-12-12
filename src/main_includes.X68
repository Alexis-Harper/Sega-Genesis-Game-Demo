; ******************************************************************
; Main
; ******************************************************************

    ; Defines
    INCLUDE defines.X68

    ; ROM Header
    INCLUDE header.X68

    ; Entry Point (hardware reset & init)
    INCLUDE entry_point.X68

    ; Init Program
    INCLUDE init.X68

    ; Main Loop
    INCLUDE main_loop.X68
    
    ; VDP Subroutines
    INCLUDE vdp_sub.X68
    
    ; VDP Sprite Subroutines
    INCLUDE vdp_sprite_sub.X68
    
    ; VDP Data
    INCLUDE assets/vdp_characters.x68
    
    ; Test sprite data
    INCLUDE data/test_sprite.X68
    
    ; Z80 Data
    INCLUDE z80_data.X68
    
    ; VDP Default Register Values
    INCLUDE vdp_registers.X68
    
    ; Controller Subroutines
    INCLUDE joypad_sub.X68
    
    ; Exceptions & Interupts
    INCLUDE interupts.X68

__end:        ; End of ROM
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
