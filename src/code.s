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
	call WaitVBlank
	call TurnLCDOff
	ld a,(LCDC)
	res 4,a
	ld (LCDC),a
	xor a
	ld (ScreenScroll0),a
	ld (ScreenScroll1),a
	ld (ScreenScroll2),a
	ld (ScreenScroll3),a
	ld a,$01
	ld (ScreenScrollSpeed0),a
	ld a,$01
	ld (ScreenScrollSpeed1),a
	ld a,$03
	ld (ScreenScrollSpeed2),a
	ld a,$06
	ld (ScreenScrollSpeed3),a
	ld bc,spritesheet_tile_data
	ld hl,VRAM_TILE_START
	ld de,spritesheet_tile_data_size
	call MemCpy
	ld a,%00110100
	ld (OBJP0),a
	ld a,%10000000
	ld (BGP),a
	ld hl,VRAM_BGMAP0_START
	ld de,VRAM_BGMAP0_END
	ld b,$00
	call MemSet
	call InitShadowOAM
	ld hl,SHADOW_OAM_HEAD
	ld de,SHADOW_OAM_TAIL
	ld b,$00
	call MemSet
	call PlayerInit
	call LoadStars
	call TurnOAMOn
	call TurnLCDOn

MainLoop:
	call ScrollBG
	call WaitVBlank
	call HandleInput

_GameCode:
	call PlayerUpdate

_UpdateOAM:
	call StartDMA
	jr MainLoop
	ret

HandleInput:
	ld a,%00100000
	ld (JOYP),a
	ld a,(JOYP)
	ld a,(JOYP)
	ld (InputBtn),a
	ld a,%00010000
	ld (JOYP),a
	ld a,(JOYP)
	ld a,(JOYP)
	ld (InputDir),a
	ret

ScrollBG:
	ld a,(ScreenScrollSpeed0)
	ld b,a
	ld a,(ScreenScrollSpeed1)
	ld c,a
	ld a,(ScreenScrollSpeed2)
	ld d,a
	ld a,(ScreenScrollSpeed3)
	ld e,a
	ld a,$00
	call WaitLYC
	ld a,(ScreenScroll0)
	add a,e
	ld (ScreenScroll0),a
	ld (SCX),a
	ld a,38
	call WaitLYC
	ld a,(ScreenScroll1)
	add a,d
	ld (ScreenScroll1),a
	ld (SCX),a
	ld a,51
	call WaitLYC
	ld a,(ScreenScroll2)
	add a,c
	ld (ScreenScroll2),a
	ld (SCX),a
	ld a,68
	call WaitLYC
	ld a,(ScreenScroll3)
	add a,b
	ld (ScreenScroll3),a
	ld (SCX),a
	ld a,75
	call WaitLYC
	ld a,(ScreenScroll2)
	ld (SCX),a
	ld a,85
	call WaitLYC
	ld a,(ScreenScroll1)
	ld (SCX),a
	ld a,105
	call WaitLYC
	ld a,(ScreenScroll0)
	ld (SCX),a

	ret

LoadStars:
	ld bc,screen_map_data
	ld hl,VRAM_BGMAP0_START
	ld de,screen_tile_map_size
	call MemCpy
	ld bc,screen_tile_data
	ld hl,$9000
	;ld de,$07C0
	ld de,$07ff
	call MemCpy
	ld bc,screen_tile_data+$07ff
	ld hl,$8800
	ld de,$07ff
	call MemCpy
	ret

PlayerInit:
	; Body
	ld a,$01
	ld (SPRITE0_TILE),a
	ld a,$02
	ld (SPRITE1_TILE),a
	ld a,$03
	ld (SPRITE2_TILE),a
	ld a,$04
	ld (SPRITE3_TILE),a
	ld a,8
	ld (SPRITE0_X),a
	ld a,16
	ld (SPRITE0_Y),a
	ld a,16
	ld (SPRITE1_X),a
	ld a,16
	ld (SPRITE1_Y),a
	ld a,8
	ld (SPRITE2_X),a
	ld a,24
	ld (SPRITE2_Y),a
	ld a,16
	ld (SPRITE3_X),a
	ld a,24
	ld (SPRITE3_Y),a

	; Particle
	ld a,5
	ld (SPRITE4_TILE),a
	ld a,5
	ld (SPRITE5_TILE),a

	; Position
	ld a,160/2-4
	ld a,144/2-4
	ld (PlayerX),a
	ld (PlayerY),a
	xor a
	ld (PlayerParticleFrame),a
	ld (PlayerState),a
	ld a,BOOSTER_DELAY
	ld (PlayerParticleDelay),a

	; Bullets
	ld hl,SPRITE6
_ResetBullet:
	ld a,$00
	ld (hl+),a
	ld (hl+),a
	ld a,11
	ld (hl+),a
	inc hl
	ld a,l
	cp (SPRITE11)'b
	jr nz,_ResetBullet
	xor a
	ld (PlayerBulletCounter0),a
	ld (PlayerBulletCounter1),a
	ld (PlayerShootingDelay),a
	ld hl,PlayerBullets
	ld de,PlayerBullets+BULLET_COUNT
	ld b,$00
	call MemSet
	ret

PlayerUpdate:
	call PlayerUpdateBullets
	call PlayerUpdateSprite
	call PlayerInput
	ret

PlayerInput:
	ld a,(PlayerState)
	set 0,a
	res 1,a
	ld (PlayerState),a
	ld a,(InputDir)
	ld d,a
	ld a,(InputBtn)
	ld e,a
_CheckDown:
	bit 3,e
	jr nz,_CheckUp
	ld a,(PlayerY)
	cp 144-16
	jr nc,_CheckLeft
	inc a
	ld (PlayerY),a
	ld a,(PlayerState)
	set 0,a
	ld (PlayerState),a
	jr _CheckLeft
_CheckUp:
	bit 2,e
	jr nz,_CheckLeft
	ld a,(PlayerY)
	cp $00
	jr z,_CheckLeft
	dec a
	ld (PlayerY),a
	ld a,(PlayerState)
	set 0,a
	ld (PlayerState),a
_CheckLeft:
	bit 1,e
	jr nz,_CheckRight
	ld a,(PlayerState)
	res 0,a
	ld (PlayerState),a
	ld a,(PlayerX)
	cp $00
	jr z,_EndDirCheck
	dec a
	ld (PlayerX),a
	jr _EndDirCheck
_CheckRight:
	bit 0,e
	jr nz,_EndDirCheck
	ld a,(PlayerState)
	set 0,a
	set 1,a
	ld (PlayerState),a
	ld a,(PlayerX)
	cp 160-32
	jr nc,_EndDirCheck
	add a,2
	ld (PlayerX),a
	
_EndDirCheck:
_CheckButtons:
	bit 0,d ; Button A
	jr nz,_DontShoot
	call PlayerShoot
	jr _EndCheck

_DontShoot:
	ld a,SHOOTING_DELAY
	ld (PlayerShootingDelay),a

_EndCheck:
	ret

PlayerShoot:
	; Check delay first
	ld a,(PlayerShootingDelay)
	ld d,a
	inc a
	ld (PlayerShootingDelay),a
	ld a,d
	cp SHOOTING_DELAY
	jr nz,_PlayerCantShoot
	xor a
	ld (PlayerShootingDelay),a
	; Check if we have enough bullets
	ld a,(PlayerBulletCounter0)
	cp BULLET_COUNT * 2
	jr z,_PlayerCantShoot
	ld d,a
	add a,2
	ld (PlayerBulletCounter0),a
	ld a,(PlayerBulletCounter1)
	ld e,a
	inc a
	ld (PlayerBulletCounter1),a
	ld e,-1
	ld d,-2
	ld hl,PlayerBullets
_SearchBulletToShoot:
	inc e
	ld a,e
	cp BULLET_COUNT
	jr z,_PlayerCantShoot
	inc d
	inc d
	ld a,(hl+)
	cp $00
	jr nz,_SearchBulletToShoot
	ld hl,PlayerBulletPtrs
	ld a,d
	add a,l
	; Derefernce bullet address
	ld l,a
	ld a,(hl+)
	ld b,a
	ld a,(hl)
	ld h,a
	ld l,b
	; hl now holds dest for current bullet
	ld a,(PlayerY)
	add a,24
	ld (hl+),a
	ld a,(PlayerX)
	add a,24
	ld (hl),a
	; Set bullet state to active
	ld hl,PlayerBullets
	ld a,e
	add a,l
	ld l,a
	ld a,(hl)
	cp $00
	jr nz,_Search
	ld a,$01
	ld (hl),a
	jr _PlayerCantShoot

_Search:
	ld hl,PlayerBullets-1
	jr _SearchBullet
_SearchBullet0:
	;halt
_SearchBullet:
	inc hl
	ld a,l
	cp (PlayerBullets+5)'lo
	jr z,_Search
	ld a,(hl)
	cp $00
	jr nz,_SearchBullet0
	ld a,$01
	ld (hl),a

_PlayerCantShoot
	ret

PlayerUpdateBullets:
	ld a,(PlayerBulletCounter1)
	cp 0
	jr z,_NoBullets
	ld hl,PlayerBullets
	ld d,(PlayerBullets + BULLET_COUNT)'lo
	ld bc,SPRITE6-OAM_STRIDE
_CheckBullet:
	inc bc
	inc bc
	inc bc
	inc bc
	ld a,l
	cp d
	jr z,_NoBullets
	ld a,(hl)
	cp $00
	jr z,_UpdateBulletAddr
_UpdateBulletMovement:
	; Update active bullet
	ld a,h
	ld (Temp),a
	ld e,l
	ld h,b
	ld l,c
	inc hl
	ld a,(hl)
	add a,4
	ld (hl),a
	cp 168
	jr c,_DontDisableBullet

_KillBullet:
	ld a,(PlayerBulletCounter0)
	sub 2
	ld (PlayerBulletCounter0),a
	ld a,(PlayerBulletCounter1)
	dec a
	ld (PlayerBulletCounter1),a
	ld a,(Temp)
	ld h,a
	ld l,e
	ld a,$00
	ld (hl),a
	inc hl
	jr _CheckBullet

_DontDisableBullet:
	ld a,(Temp)
	ld h,a
	ld l,e
	inc hl
	jr _CheckBullet

_UpdateBulletAddr:
	inc hl
	jr _CheckBullet

_NoBullets:
	ret

CheckBulletCollision:
	ret

PlayerUpdateSprite:
	ld a,(PlayerX)
	ld d,a
	ld a,(PlayerY)
	ld e,a
	ld a,8
	add a,d
	ld (SPRITE0_X),a
	ld a,16
	add a,e
	ld (SPRITE0_Y),a
	ld a,16
	add a,d
	ld (SPRITE1_X),a
	ld a,16
	add a,e
	ld (SPRITE1_Y),a
	ld a,8
	add a,d
	ld (SPRITE2_X),a
	ld a,24
	add a,e
	ld (SPRITE2_Y),a
	ld a,16
	add a,d
	ld (SPRITE3_X),a
	ld a,24
	add a,e
	ld (SPRITE3_Y),a
	; Update Particle animation
	ld a,(PlayerState)
	bit 0,a
	jr nz,_TestDelay
	xor a
	ld (SPRITE4_TILE),a
	ld (SPRITE5_TILE),a
	jr _EndPlayerUpdateSprite
_TestDelay:
	ld a,(PlayerParticleDelay)
	dec a
	ld (PlayerParticleDelay),a
	cp $00
	jr nz,_EndPlayerUpdateSprite
	ld a,BOOSTER_DELAY
	ld (PlayerParticleDelay),a
	ld (PlayerParticleDelay),a
	ld hl,ParticleFrames
	ld a,(PlayerParticleFrame)
	add a,l
	ld l,a
	ld a,(hl)
	ld b,a
	ld (SPRITE4_TILE),a
	ld a,(PlayerState)
	bit 1,a
	jr z,_NoJet
	ld a,b
	ld (SPRITE5_TILE),a
	jr _Continue
_NoJet:
	ld a,0
	ld (SPRITE5_TILE),a
_Continue:
	ld a,(PlayerParticleFrame)
	inc a
	and 7
	ld (PlayerParticleFrame),a
	ld a,0
	add a,d
	ld (SPRITE4_X),a
	ld a,16
	add a,e
	ld (SPRITE4_Y),a
	ld a,0
	add a,d
	ld (SPRITE5_X),a
	ld a,24
	add a,e
	ld (SPRITE5_Y),a
_EndPlayerUpdateSprite:
	ret

	lib Assets
	lib Registers
	lib Utils

	org $2000
	; ===========
ParticleFrames:
	db 5,6,7,8,9,10,0,0
PlayerBulletPtrs:
	dw SPRITE6,SPRITE7,SPRITE8,SPRITE9,SPRITE10
	; ===========


	lib ShadowOAM
	lib Variables



