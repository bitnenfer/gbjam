	;Variables
WorkRam group $00

	org $C000
PlayerX: ds 1
PlayerY: ds 1
PlayerParticleFrame: ds 1
PlayerParticleDelay: ds 1

; bit 0 (0 = Not Moving | 1 = Moving)
BOOSTER_DELAY equ 2
BULLET_COUNT equ 5
SHOOTING_DELAY equ 9
SHOOTING_FLASH_DELAY equ 0
PlayerState: ds 1 
PlayerBullets: ds BULLET_COUNT
PlayerBulletCounter0: ds 1
PlayerBulletCounter1: ds 1
PlayerShootingDelay: ds 1

ScreenScroll0: ds 1
ScreenScroll1: ds 1
ScreenScroll2: ds 1
ScreenScroll3: ds 1
ScreenScrollSpeed0: ds 1
ScreenScrollSpeed1: ds 1
ScreenScrollSpeed2: ds 1
ScreenScrollSpeed3: ds 1

InputBtn: ds 1
InputDir: ds 1

Temp: ds 1