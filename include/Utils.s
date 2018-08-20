; Utility Functions
TurnLCDOff:
	ld a,(LCDC)
	res 7,a
	ld (LCDC),a
	ret

TurnLCDOn:
	ld a,(LCDC)
	set 7,a
	ld (LCDC),a
	ret

TurnOAMOn:
	ld a,(LCDC)
	set 1,a
	ld (LCDC),a
	ret

TurnOAMOff:
	ld a,(LCDC)
	res 1,a
	ld (LCDC),a
	ret

WaitLYC:
	; A = Line To Wait
	ld (LYC),a
_Wait:
	ld a,(LCDS)
	bit $02,a
	jr z,_Wait
	ret

WaitHBlank:
_Wait:
	ld a,(LCDS)
	and $03
	jr nz,_Wait
	ret


LoadMapRow:
	; BC = Source
	; HL = Dest
	; D = Row Stride
_Loop:
	ld a,(bc)
	ld (hl),a
	inc bc
	inc hl
	dec d
	jr nz,_Loop
	ret

WaitVBlank:
	ld hl,LYC
	ld (hl),$90
_Wait:
	ld a,(LCDS)
	bit $02,a
	jr z,_Wait
	ret

MemCpy:
	; BC = Source
	; HL = Dest
	; DE = Block Size
	dec de
_MemCpyLoop:
	ld a,(bc)
	ld (hl),a
	inc bc
	inc hl
	dec de
_MemCpyChkLimit:
	ld a,e
	cp $00
	jr nz,_MemCpyLoop
	ld a,d
	cp $00
	jr nz,_MemCpyLoop
	ret

MemSet:
	; HL = Start
	; DE = End
	; B = Value
_MemSetLoop:
	ld (hl),b
	inc hl
	ld a,h
	cp d
	jr nz,_MemSetLoop
	ld a,l
	cp e
	jr nz,_MemSetLoop
	ld h,d
	ld l,e
	ld (hl),b
	ret

Sleep:
	; HL counter
_Repeat:
	dec hl
	ld a,l
	cp $00
	jr nz, _Repeat
	ld a,h
	cp $00
	jr nz, _Repeat
	ret