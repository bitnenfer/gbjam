spritesheet_tile_data_size EQU $D1

spritesheet_tile_data:
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$3F,$1B,$24,$1B,$24,$03,$FC,$5C,$A3,$1D,$E2,$41,$BF,$1D,$E3
  DB $00,$00,$00,$C0,$C0,$20,$E0,$10,$00,$F0,$E0,$10,$E0,$F0,$E0,$F0
  DB $1F,$20,$1F,$20,$00,$3F,$1F,$FF,$5F,$BF,$00,$FF,$00,$FF,$00,$3F
  DB $E0,$1C,$F4,$0E,$36,$CF,$D6,$EF,$C0,$FF,$36,$C9,$06,$F9,$00,$FE
  DB $00,$06,$06,$0F,$06,$0F,$06,$0F,$06,$0F,$06,$0F,$06,$0F,$00,$06
  DB $00,$0E,$0E,$1F,$1E,$3F,$1E,$3F,$1E,$3F,$1E,$3F,$0E,$1F,$00,$0E
  DB $00,$00,$00,$1C,$1C,$3E,$3C,$7E,$3C,$7E,$1C,$3E,$00,$1C,$00,$00
  DB $00,$00,$00,$00,$00,$1C,$1C,$3E,$3C,$7E,$1C,$3E,$00,$1C,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$60,$60,$F0,$00,$60,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$20,$70,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$7E,$7E,$9F,$7E,$BF,$7E,$BF,$7E,$9F,$00,$7E,$00,$00
  DB $07,$07,$1F,$1F,$3F,$3F,$7F,$7F,$7F,$7F,$FF,$FF,$FF,$FF,$FF,$FF

; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: screen.png
; Pixel Width: 256px
; Pixel Height: 144px

; /////////////////
; //             //
; //  Constants  //
; //             //
; /////////////////

screen_tile_map_size EQU $0240
screen_tile_map_width EQU $20
screen_tile_map_height EQU $12

screen_tile_data_size EQU $0510
screen_tile_count EQU $0240

; ////////////////
; //            //
; //  Map Data  //
; //            //
; ////////////////

screen_map_data:
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $01,$02,$00,$00,$00,$00,$03,$04,$05,$06,$04,$07,$01,$02,$00,$00
  DB $00,$00,$03,$04,$01,$02,$00,$00,$00,$00,$03,$04,$05,$06,$04,$07
  DB $08,$08,$05,$03,$03,$09,$08,$08,$08,$08,$08,$08,$08,$08,$05,$03
  DB $03,$09,$08,$08,$08,$08,$05,$03,$03,$09,$08,$08,$08,$08,$08,$08
  DB $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
  DB $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
  DB $0A,$0B,$0C,$0D,$0E,$0F,$10,$08,$08,$11,$0B,$0A,$0B,$0C,$0D,$0E
  DB $0F,$10,$11,$0B,$0A,$0B,$0C,$0D,$0E,$0F,$10,$08,$08,$11,$0B,$0A
  DB $12,$12,$12,$12,$12,$12,$12,$13,$14,$12,$12,$12,$12,$12,$12,$12
  DB $12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$12,$13,$14,$12,$12,$12
  DB $15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24
  DB $25,$26,$27,$28,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20
  DB $29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29
  DB $29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29
  DB $29,$29,$2A,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29,$29
  DB $29,$29,$29,$29,$29,$29,$2A,$29,$29,$29,$29,$29,$29,$29,$29,$29
  DB $2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A
  DB $3B,$3C,$3D,$3E,$2B,$2C,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36
  DB $3F,$3F,$3F,$3F,$3F,$3F,$3F,$40,$41,$3F,$3F,$3F,$3F,$3F,$3F,$3F
  DB $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,$40,$41,$3F,$3F,$3F
  DB $42,$43,$44,$45,$46,$47,$48,$48,$48,$49,$43,$42,$43,$44,$45,$46
  DB $47,$48,$49,$43,$42,$43,$44,$45,$46,$47,$48,$48,$48,$49,$43,$42
  DB $48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48
  DB $48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48,$48
  DB $48,$48,$4A,$00,$00,$4B,$48,$48,$48,$48,$48,$48,$48,$48,$4A,$00
  DB $00,$4B,$48,$48,$48,$48,$4A,$00,$00,$4B,$48,$48,$48,$48,$48,$48
  DB $4C,$4D,$00,$00,$00,$00,$00,$4E,$4A,$4F,$4E,$50,$4C,$4D,$00,$00
  DB $00,$00,$00,$4E,$4C,$4D,$00,$00,$00,$00,$00,$4E,$4A,$4F,$4E,$50
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
  DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

screen_tile_data:
  DB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $00,$FF,$80,$FF,$00,$FF,$A0,$FF,$00,$FF,$A8,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$02,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$02,$FF,$00,$FF,$0A,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$80,$FF,$00,$FF,$A0,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$A8,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$0A,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF
  DB $00,$FF,$00,$FF,$00,$FF,$02,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF
  DB $01,$FF,$AA,$FF,$05,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$40,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$40,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $04,$FF,$AA,$FF,$05,$FF,$AA,$FF,$15,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$50,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$04,$FF,$AA,$FF,$15,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $00,$FF,$AA,$FF,$01,$FF,$AA,$FF,$05,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $40,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $01,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$F7,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$EB,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$D5,$FF,$EA,$FF,$F5,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$5D,$FF,$AE,$FF,$5F,$FF,$BF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$75,$FF,$EA,$FF,$F5,$FF,$FA,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$BF,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$57,$FF,$AF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$EF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$D7,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$D5,$FF,$EB,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$BA,$FF,$5D,$FF,$BF,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$EA,$FF,$D5,$FF,$EA,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$7F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$55,$FF,$FA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$BA,$FF,$7D,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$EA,$FF,$D5,$FF,$EA,$FF,$F5,$FF,$FE,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$57,$FF,$AF,$FF,$5F,$FF,$BF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AA,$FF,$5D,$FF,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$AE,$FF,$57,$FF,$AF,$FF,$5F,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $55,$FF,$EA,$FF,$F5,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$F5,$FF
  DB $FF,$FF,$F7,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$EB,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $EA,$FF,$D5,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $BF,$FF,$5F,$FF,$AE,$FF,$5D,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FA,$FF,$F5,$FF,$EA,$FF,$75,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$7F,$FF,$BF,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$AF,$FF,$57,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$EF,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$D7,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $EB,$FF,$D5,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$7F,$FF,$BF,$FF,$5D,$FF,$BA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$F5,$FF,$EA,$FF,$D5,$FF,$EA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$7F,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$7D,$FF,$BA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FE,$FF,$F5,$FF,$EA,$FF,$D5,$FF,$EA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $BF,$FF,$5F,$FF,$AF,$FF,$57,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FE,$FF,$5D,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$5F,$FF,$AF,$FF,$57,$FF,$AE,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $FF,$FF,$FF,$FF,$FF,$FF,$F5,$FF,$EA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$55,$FF
  DB $AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$40,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$55,$FF,$AA,$FF,$55,$FF,$AA,$FF,$01,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$55,$FF,$AA,$FF,$05,$FF,$AA,$FF,$01,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$55,$FF,$AA,$FF,$40,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$40,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$15,$FF,$AA,$FF,$05,$FF,$AA,$FF,$04,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$50,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$15,$FF,$AA,$FF,$04,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$05,$FF,$AA,$FF,$01,$FF,$AA,$FF,$00,$FF,$AA,$FF,$00,$FF
  DB $AA,$FF,$00,$FF,$A0,$FF,$00,$FF,$80,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $AA,$FF,$00,$FF,$02,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $A8,$FF,$00,$FF,$A0,$FF,$00,$FF,$80,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $02,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $0A,$FF,$00,$FF,$02,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $A8,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
  DB $AA,$FF,$00,$FF,$0A,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF






