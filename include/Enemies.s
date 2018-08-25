EnemiesInit:
  ld a,ENEMY_SPAWN_DELAY
  ld (EnemySpawnCounter),a
  ld hl,SPRITE9
  ld d,MAX_ENEMIES
  ld a,$0D
_SetTile:
  dec d
  jr z,_NextStep
  inc hl
  inc hl
  ld (hl+),a
  inc hl
  jr _SetTile
_NextStep:
  ld hl,Enemies
  ld d,MAX_ENEMIES
  xor a
_ClearEnemies:
  ld (hl+),a
  dec d
  ret z
  jr _ClearEnemies

EnemiesSpawnOne:
  ld hl,Enemies
  ld d,MAX_ENEMIES
_Search:
  dec d
  ret z ; No available enemies
  ld a,(hl+)
  cp $00
  jr nz,_Search
  ; we found one!
  ld a,$01
  dec hl
  ld (hl),a
  ld a,MAX_ENEMIES
  sub d
  dec a
  rl a
  rl a
  ld hl,SPRITE9
  add a,l
  ld l,a
  call FastRand
  ld (hl+),a
  ld a,160+16
  ld (hl),a
  ret

EnemyKill:
  ; hl = enemy to kill
  ; d = index
  xor a
  ld (hl),a
  ld hl,SPRITE9
  ld a,d
  dec a
  rl a
  rl a
  add a,l
  ld l,a
  xor a
  ld (hl+),a
  ld (hl),a
  ret

EnemiesUpdate:
  ld a,(EnemySpawnCounter)
  dec a
  ld (EnemySpawnCounter),a
  jr nz,_ContinueUpdate
  ld a,ENEMY_SPAWN_DELAY
  ld (EnemySpawnCounter),a
  call EnemiesSpawnOne

_ContinueUpdate:
  ld bc,SPRITE8  ; enemy sprite start a sprite 9
                 ; but we start a sprite9 - 1
  ld hl,Enemies
  ld a,MAX_ENEMIES
  ld (Temp),a
_CheckEnemy:
  ld a,(Temp)
  ret z
  inc bc
  inc bc
  inc bc
  inc bc ; increment by sizeof(sprite)
  ld a,(hl+)
  cp $00
  jr z,_Continue
  ld d,h
  ld e,l
  ld h,b
  ld l,c
  inc hl
  dec (hl) ; move to the left
  dec (hl) ; move to the left
  ld a,(hl)
  cp $00
  jr z,_KillEnemy
  ld h,d
  ld l,e
  jr _Continue
_KillEnemy:
  dec hl
  xor a
  ld (hl+),a
  ld (hl),a
  ld h,d
  ld l,e
  dec hl
  ld (hl+),a
_Continue:
  ld a,(Temp)
  dec a
  ld (Temp),a
  jr _CheckEnemy
  ret