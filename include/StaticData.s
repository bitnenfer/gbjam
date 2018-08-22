  org $2000
  ; ===========
ParticleFrames:
  db 5,6,7,8,9,10,0,0
PlayerBulletPtrs:
  dw SPRITE6,SPRITE7,SPRITE8,SPRITE9,SPRITE10
Text0:
  db "HELLO GBJAM",0
Text1:
  db "THIS IS A TEST TEXT",0
Text2:
  db "SCORE OOOOO",0
Text3:
  db "BEEP BOOP BEEP BOOP",0
LoadingText:
  db "LOADING",0
TextList:
  dw Text0,Text1,Text2,Text3
  ; ===========