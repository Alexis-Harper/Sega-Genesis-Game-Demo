; ******************************************************************
; Test Sprite
; ******************************************************************

TestSprite: ; Test Sprite
    dc.w    $0080 ; Y Position
    dc.b    $0F   ; Width (bits 0-1) and height (bits 2-3)
    dc.b    $00   ; Index of next sprite (linked list
    dc.b    $00   ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
    dc.b    $10   ; Index of first tile
    dc.w    $0080 ; X Position
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
