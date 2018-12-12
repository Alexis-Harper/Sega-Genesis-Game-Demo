; ******************************************************************
; VDP Registers
; ******************************************************************

VDPRegisters:
    dc.b    $14 ; 0: Horiz. interrupt on, display on
    dc.b    $74 ; 1: Vert. interrupt on, display on, DMA on, V28 mode (28 cells vertically), + bit 2
    dc.b    $30 ; 2: Pattern table for Scroll Plane A at $C000 (bits 3-5)
    dc.b    $40 ; 3: Pattern table for Window Plane at $10000 (bits 1-5)
    dc.b    $05 ; 4: Pattern table for Scroll Plane B at $A000 (bits 0-2)
    dc.b    $70 ; 5: Sprite table at $E000 (bits 0-6)
    dc.b    $00 ; 6: Unused
    dc.b    $00 ; 7: Background colour - bits 0-3 = colour, bits 4-5 = palette
    dc.b    $00 ; 8: Unused
    dc.b    $00 ; 9: Unused
    dc.b    $00 ; 10: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam)
    dc.b    $08 ; 11: External interrupts on, V/H scrolling on
    dc.b    $81 ; 12: Shadows and highlights off, interlace off, H40 mode (40 cells horizontally)
    dc.b    $34 ; 13: Horiz. scroll table at $D000 (bits 0-5)
    dc.b    $00 ; 14: Unused
    dc.b    $02 ; 15: Autoincrement on (2 bytes)
    dc.b    $01 ; 16: Vert. scroll 32, Horiz. scroll 64
    dc.b    $00 ; 17: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
    dc.b    $00 ; 18: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
    dc.b    $00 ; 19: DMA length lo byte
    dc.b    $00 ; 20: DMA length hi byte
    dc.b    $00 ; 21: DMA source address lo byte
    dc.b    $00 ; 22: DMA source address mid byte
    dc.b    $00 ; 23: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
