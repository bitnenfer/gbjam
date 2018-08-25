MenuInit:
  ; We just load every line by hand.
  ld DE, $15
  ld BC, menu_map_data + ($14 * $0)
  ld HL, $9C00
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $1)
  ld HL, $9C20
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $2)
  ld HL, $9C40
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $3)
  ld HL, $9C60
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $4)
  ld HL, $9C80
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $5)
  ld HL, $9CA0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $6)
  ld HL, $9CC0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $7)
  ld HL, $9CE0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $8)
  ld HL, $9D00
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $9)
  ld HL, $9D20
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $A)
  ld HL, $9D40
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $B)
  ld HL, $9D60
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $C)
  ld HL, $9D80
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $D)
  ld HL, $9DA0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $E)
  ld HL, $9DC0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $F)
  ld HL, $9DE0
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $10)
  ld HL, $9E00
  call VRAM_MemCpy
  ld DE, $15
  ld BC, menu_map_data + ($14 * $11)
  ld HL, $9E20
  call VRAM_MemCpy 
  ret