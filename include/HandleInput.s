HandleInput:
  ld a,%00100000
  ld (JOYP),a
  ld a,(JOYP)
  ld a,(JOYP)
  ld (InputDir),a
  ld a,%00010000
  ld (JOYP),a
  ld a,(JOYP)
  ld a,(JOYP)
  ld (InputBtn),a
  ret