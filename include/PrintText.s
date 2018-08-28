PrintText:
  ; HL = Text address. NULL terminated
  ld c,$00
_Read:
_WaitVBlankAtWrite:
  ld a,(LCDS)
  and $03
  cp $01
  jr nz,_WaitVBlankAtWrite
  ld a,(hl+)
  ld d,h
  ld e,l
  cp $00
  jr z,_End
  ; Target dest $9C00
  add a,73
  ld h,$9C
  ld l,c
  ld (hl),a
  ld h,d
  ld l,e
  inc c
  jr _Read
_End:
  ld h,$9C
  ld l,c
_Clear:
_WaitVBlankAtClear:
  ld a,(LCDS)
  and $03
  cp $01
  jr nz,_WaitVBlankAtClear
  ld a,$69
  ld (hl+),a
  ld a,l
  cp 20
  ld l,a
  jr nz,_Clear
  ret

PrintTextNotSafe:
  ; HL = Text address. NULL terminated
  ld c,$00
_Read:
  ld a,(hl+)
  ld d,h
  ld e,l
  cp $00
  jr z,_End
  ; Target dest $9C00
  add a,73
  ld h,$9C
  ld l,c
  ld (hl),a
  ld h,d
  ld l,e
  inc c
  jr _Read
_End:
  ld h,$9C
  ld l,c
_Clear:
  ld a,$69
  ld (hl+),a
  ld a,l
  cp 20
  ld l,a
  jr nz,_Clear
  ret

EnableTextBuffer:
  ld a,(LCDC)
  set 5,a
  ld (LCDC),a
  ret

DisableTextBuffer:
  ld a,(LCDC)
  res 5,a
  ld (LCDC),a
  ret

  ; This must be called with the
  ; LCD off
InitTextBuffer:
  ld a,(LCDC)
  set 6,a
  ld (LCDC),a
  ; Fonts
  ld bc,font_tile_data
  ld hl,$8800
  ld de,font_tile_data_size
  call VRAM_MemCpy
  ; Clear text buffer
  ld hl,$9C00
_ClearTextBuffer:
_WaitVBlank:
  ld a,(LCDS)
  and $03
  cp $01
  jr nz,_WaitVBlank
  ld a,$69
  ld (hl+),a
  ld a,l
  cp $FF
  jr nz,_ClearTextBuffer
  ret