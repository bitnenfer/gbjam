  isv810
  isdmg
  offbankgroup
  puball
title group $00
  org $0040 ; vblank
  reti
  org $0048 ; lcd stat
  reti
  org $0050 ; timer
  reti
  org $0058 ; serial
  reti
  org $0060 ; joypad
  reti
  org $0100
  nop
  jp $0150
  db $CE,$ED,$66,$66
  db $CC,$0D,$00,$0B
  db $03,$73,$00,$83
  db $00,$0C,$00,$0D
  db $00,$08,$11,$1F
  db $88,$89,$00,$0E
  db $DC,$CC,$6E,$E6
  db $DD,$DD,$D9,$99
  db $BB,$BB,$67,$63
  db $6E,$0E,$EC,$CC
  db $DD,$DC,$99,$9F
  db $BB,$B9,$33,$3E
  db $00,$00,$00,$00
  db $00,$00,$00,$00
  db $00,$00,$00,$00
  db $00,$00,$00
  db $00
  db $00,$00
  db $00
  db $00
  db $00
  db $00
  db $01
  db $00
  db $00
  db $67
  db $00,$00
  
Main group $00
  org $0150

StartDMA equ $FF80

EntryPoint:
  ; Initial asset loading
  call InitTextBuffer
  call EnableTextBuffer

  ; Initialize random seed
  ld a,(DIV)
  ld (FastRandSeed),a

  ; Set window x position
  ld a,$07
  ld (WX),a

  ; Set Loading Text
  ld hl,LoadingText
  call PrintText

  ; Initialize Input
  ld a,$FF
  ld (InputDir),a
  ld (InputBtn),a
  
  ; Initial Game Code
  ld hl,GameCodeInit
  call StartLoad
  stop


StartLoad:
  jp (hl)
  ret

  ; Code and Data
  lib Utils
  lib HandleInput
  lib Menu
  lib GameCode
  lib PrintText
  lib Enemies
  lib Player
  lib Font
  lib SpriteData
  lib ScreenData
  lib MainData
  lib Registers

  ; This have their own address
  lib StaticData
  lib ShadowOAM
  lib Variables



