GameCodeInit:
  ; Set window position for loading
  xor a
  ld (WY),a

  ; Load sprite data
  ld bc,spritesheet_tile_data
  ld hl,VRAM_TILE_START
  ld de,spritesheet_tile_data_size
  call VRAM_MemCpy

  ; Clear map data
  ld hl,VRAM_BGMAP0_START
  ld de,VRAM_BGMAP0_END
  ld b,$00
  call VRAM_MemSet

  ; Initialize shadow OAM
  call InitShadowOAM

    ; Clear shadow OAM
  ld hl,SHADOW_OAM_HEAD
  ld de,SHADOW_OAM_TAIL
  ld b,$00
  call MemSet
  
  ; Load Player
  call PlayerInit
  
  ; Load Background
  call LoadBG
  
  ; Enable Sprites
  ld a,(LCDC)
  set 1,a
  res 4,a
  ld (LCDC),a

  ; Set scrolling speed 
  ; of the background
  xor a
  ld (ScreenScroll0),a
  ld (ScreenScroll1),a
  ld a,$03
  ld (ScreenScrollSpeed0),a
  ld a,$01
  ld (ScreenScrollSpeed1),a

  ; This is to avoid getting 
  ; artifacts
  xor a
  ld (BGP),a
  ld (OBJP0),a

  ; Force a DMA transfer
  ; before starting game loop
  call StartDMA

  ; Set window position
  ld a,144-8
  ld (WY),a

  ; Initialize text buffer
  ld hl,Text0
  call PrintText
  xor a
  ld (Text),a
  

  ; Always call this at the end
  ; of initialization or you'll
  ; see artifacts.
  ; Set background and
  ; sprite palette
  ld a,%00110100
  ld (OBJP0),a
  ld a,%11100100
  ld (BGP),a
  
GameCodeLoop:
  call ScrollBG
  call HandleInput
_GameCode:
  call WaitVBlank
  call TestTextLoading
  call PlayerUpdate
_UpdateOAM:
  call StartDMA
  jr GameCodeLoop

TestTextLoading:
  ld a,(InputBtn)
  bit 1,a
  jr nz,_End
  ld a,(Btn)
  cp $01
  ret z
  ld a,$01
  ld (Btn),a
  ld a,(Text)
  inc a
  and 3
  ld (Text),a
  ld hl,TextList
  add a,a
  add a,l
  ld l,a
  ld a,(hl+)
  ld b,a
  ld a,(hl)
  ld h,a
  ld l,b
  call PrintTextNotSafe
  ret
_End:
  ld a,$00
  ld (Btn),a
  ret

CheckBulletCollision:
  ret

LoadBG:
  ; Map
  ld bc,screen_map_data
  ld hl,VRAM_BGMAP0_START
  ld de,screen_tile_map_size
  call VRAM_MemCpy
  ; Tiles
  ld bc,screen_tile_data
  ld hl,$9000
  ld de,screen_tile_data_size
  call VRAM_MemCpy
  ret

ScrollBG:
  ld a,(ScreenScrollSpeed0)
  ld b,a
  ld a,(ScreenScrollSpeed1)
  ld c,a
  ld a,$00
  call WaitLYC
  ld a,(ScreenScroll0)
  add a,b
  ld (ScreenScroll0),a
  ld (SCX),a
  ld a,32
  call WaitLYC
  ld a,(ScreenScroll1)
  add a,c
  ld (ScreenScroll1),a
  ld (SCX),a
  ld a,92
  call WaitLYC
  ld a,(ScreenScroll1)
  ld (SCX),a
  ld a,111
  call WaitLYC
  ld a,(ScreenScroll0)
  ld (SCX),a
  ld a,144
  call WaitLYC
  xor a
  ld (SCX),a
  ret