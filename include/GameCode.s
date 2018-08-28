
GameCodeInit:
  ; Set window position for loading
  xor a
  ld (WY),a

  ; Load sprite data
  ld bc,sprites_tile_data
  ld hl,VRAM_TILE_START
  ld de,sprites_tile_data_size
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

  ; Load Enemies
  call EnemiesInit
  
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

  ; Set the address for objects
  ld hl,SPRITE11
  ld a,h
  ld (ObjectPtr),a
  ld a,l
  ld (ObjectPtr+1),a

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
  ld a,%00101100
  ld (OBJP0),a
  ld a,%11000100
  ld (BGP),a

GameCodeLoop:
  call ScrollBG
_GameCode:
  call WaitVBlank
  call TestTextLoading

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

BULLET_LUT: dw SPRITE6,SPRITE7,SPRITE8
ENEMY_LUT: dw SPRITE9,SPRITE10,SPRITE11,SPRITE12,SPRITE13

CheckBulletEnemyCollision:
  ld hl,PlayerBullets
  ld e,BULLET_COUNT
_RepBullet:
  dec e
  ret z ; no more bullets to check
  ld a,(hl+)
  cp $00
  jr z,_RepBullet
  ld b,h
  ld c,l
  ld hl,Enemies
  ld d,MAX_ENEMIES
_RepEnemies:
  dec d
  jr z,_RepBullet ; no more enemies to check
  ld a,(hl+)
  cp $00
  jr z,_RepEnemies
  dec hl
  ld a,h
  ld (EnemyAddress),a
  ld a,l
  ld (EnemyAddress+1),a
  inc hl
  ; We have a live bullet and a live enemy
  ; now let's check for collision.

  ; save current hl and de
  ld a,h
  ld (Temp),a
  ld a,l
  ld (Temp+1),a
  ld a,d
  ld (Temp+2),a
  ld a,e
  ld (Temp+3),a

  ; get bullet
  ld a,d
  dec a
  rl a
  ld hl,BULLET_LUT
  add a,l
  ld l,a

  ld a,(hl+)
  ld d,a
  ld a,(hl)
  ld h,a
  ld l,d

  ld a,(hl)
  ld (BulletY),a
  ld a,(hl)
  ld (BulletX),a

  ; get enemy
  ld a,e
  dec a
  rl a
  ld hl,ENEMY_LUT
  add a,l
  ld l,a

  ld a,(hl+)
  ld d,a
  ld a,(hl)
  ld h,a
  ld l,d

  ld a,(hl+)
  ld (EnemyY),a
  ld a,(hl)
  ld (EnemyX),a

  ; now check if both collide
  ld a,(BulletX)
  ld d,a
  ld a,(EnemyX)
  call AbsSub
  cp $08
  jr nc,_NoHit
  ld a,(BulletY)
  ld d,a
  ld a,(EnemyY)
  call AbsSub
  cp $08
  jr nc,_NoHit
  ; We got collision
  ld a,(Temp+2)
  dec a
  ld d,a
  ld a,(EnemyAddress)
  ld h,a
  ld a,(EnemyAddress+1)
  ld l,a
  call EnemyKill
_NoHit:
  ; restore hl and de
  ld a,(Temp+3)
  ld e,a
  ld a,(Temp+2)
  ld d,a
  ld a,(Temp+1)
  ld l,a
  ld a,(Temp)
  ld h,a

  jp _RepEnemies

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
  call PlayerUpdate
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
  call HandleInput
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
  call EnemiesUpdate
  ld a,111
  call WaitLYC
  ld a,(ScreenScroll0)
  ld (SCX),a
  ;call CheckBulletEnemyCollision
  ld a,144
  call WaitLYC
  xor a
  ld (SCX),a
  ret

SpawnEnemy:
  call FastRand
  ld (PlayerY),a
  ret
