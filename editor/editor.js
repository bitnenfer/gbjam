
const LCD_WIDTH = 160;
const LCD_HEIGHT = 144;
const TILE_SIZE = 8;
const cursor = { x: 0, y: 0, state: 0 }; // 0 = map edit 1 = tile select
const editCursor = { x: LCD_WIDTH / 2, y: LCD_HEIGHT / 2 };
let currentTile = 0;
let lastTile = 0;
let deleteTile = 0;
let tileCountX = 0;
let tileCountY = 0;
let tiles = null;
const tilemapBuffer = document.createElement('canvas');
const tilemapBufferCtx = tilemapBuffer.getContext('2d');
const toHex = (n) => `$${("00" + n.toString(16).toUpperCase()).substr(-2)}`;
const toHex16 = (n) => `$${("0000" + n.toString(16).toUpperCase()).substr(-4)}`;
let pages = { name: mapNameInput.value, data: [] };
let tileCount = 0;
const palette = [0b11,0b10,0b01,0b00];
const tilesetData = {
  asm: '',
  size: ''
};

function clearChunk () {
  if (confirm('Are you sure you want to clear the current chunk?')) {
    tiles.data.length = 0;
    tiles.x = 0;
    tiles.y = 0;
    tiles.width = 0;
    tiles.height = 0;
    bakeData();
    reDrawTilemapBuffer();
  }
}

function populateLoadList () {
  const keys = Object.keys(localStorage);
  const loadList = document.getElementById('load');

  loadList.innerHTML = '';
  for (let i = 0; i < keys.length; ++i) {
    const option = document.createElement('option');
    option.value = keys[i];
    option.text = keys[i];
    loadList.appendChild(option);
  }
}

function loadMapData () {
  try {
    const loadElement = document.getElementById('load');
    if (loadElement.selectedIndex === -1) {
      alert(`Can't load empty map data`);
      return;
    }
    const name = loadElement.options[loadElement.selectedIndex].value;
    if (!confirm(`Are you sure you want to load the save '${name}'?`)) return;
    const data = localStorage.getItem(name);
    const obj = JSON.parse(data);
    pages = obj;
    tiles = pages.data[0];
    currentTile = 0;
    bakeData();
    reDrawTilemapBuffer();
    document.getElementById('pages').innerHTML = '';
    for (let i = 0; i < pages.data.length; ++i) {
      loadPage(pages.data[i]);
    }
    document.getElementById("mapName").value = pages.name;
  } catch (e) {
    alert('Failed to load file. Probably using the editor on incognito mode.');
  }
}

function saveMapData () {
  const saveName = prompt("Save Name", document.getElementById("mapName").value);
  if (!saveName || saveName.length === 0) {
    if (typeof saveName === 'string')
      alert(`Name can't be empty`);
    return;
  }
  for (let i = 0; i < pages.data.length; ++i) {
    const page = pages.data[i];
    const width = page.width;
    for (let j = 0; j < page.data.length; ++j) {
      if (page.data[j] === undefined) {
        page.data[j] = [];
        for (let x = 0; x < width; ++x) {
          page.data[j][x] = 0;
        }
      } else {
        for (let x = 0; x < page.data[j].length; ++x) {
          if (page.data[j][x] === undefined) page.data[j][x] = 0;
        }
      }
    }
  }
  pages.name = document.getElementById("mapName").value;
  const jsonString = JSON.stringify(pages);
  try {
    localStorage.setItem(saveName, jsonString);
  } catch (e) {
    alert('Failed to save file. Probably using the editor on incognito mode.');
  }
  populateLoadList();
}

function processTile (imageData) {
  const bytes = [];
  const data = imageData.data;

  for (let index = 0; index < data.length; index += 4 * 8) {
    const rowBits = []
    const mixBytes = [];
    for (let j = 0; j < 8 * 4; j += 4) {
      const r = data[index + j + 0];
      const g = data[index + j + 1];
      const b = data[index + j + 2];
      const a = data[index + j + 3];
      const lum = r * 0.3 + g * 0.59 + b * 0.11;
      let value = 0;
      if (lum < 85) {
        if (lum < 65) value = palette[0];
        else value = palette[1];
      } else if (lum < 170) {
        if (lum < 129) value = palette[1];
        else value = palette[2];
      } else if (lum <= 255) {
        if (lum < 193) value = palette[2];
        else value = palette[3];
      }
      mixBytes.push(value & 0b11);
    }
    for (let j = 0; j < 8; ++j) {
      const topBit = ((mixBytes[j] & 0b10) >> 1);
      rowBits.push(topBit);
    }
    for (let j = 0; j < 8; ++j) {
      const bottomBit = (mixBytes[j] & 0b01);
      rowBits.push(bottomBit)
    }
    for (let j = 0; j < rowBits.length; j += 8) {
      bytes.push((
        (rowBits[j + 0] << 7) | 
        (rowBits[j + 1] << 6) | 
        (rowBits[j + 2] << 5) | 
        (rowBits[j + 3] << 4) | 
        (rowBits[j + 4] << 3) | 
        (rowBits[j + 5] << 2) | 
        (rowBits[j + 6] << 1) | 
        (rowBits[j + 7])
      ));
    }
  }

  return bytes;
}

function readPixels (image) {
  const canvasImage = document.createElement('canvas');
  const canvasImageCtx = canvasImage.getContext('2d');
  const countX = (image.width / TILE_SIZE)|0;
  const countY = (image.height / TILE_SIZE)|0;
  const bytes = [];
  canvasImage.width = image.width;
  canvasImage.height = image.height;
  canvasImageCtx.drawImage(image, 0, 0);

  for (let y = 0; y < countY; ++y) {
    for (let x = 0; x < countX; ++x) {
      const tile = canvasImageCtx.getImageData(
        x * TILE_SIZE, 
        y * TILE_SIZE, 
        TILE_SIZE, 
        TILE_SIZE
      );
      
      Array.prototype.push.apply(bytes, processTile(tile));
    }
  }

  return bytes;
}

function bakeData () {
  const output = document.getElementById('code');
  output.innerText = '';
  output.innerText = 
`${mapNameInput.value}_tile_data_size equ ${tilesetData.size}
${mapNameInput.value}_tile_data: ${tilesetData.asm}
`
  ;
  for (let i = 0; i < pages.data.length; ++i) {
    bakeDataMap(pages.data[i], output);
  }
}

function clearAll (dontAsk) {
  if (dontAsk || confirm('Are you sure you want to clear all chunks?')) {
    pages.data.splice(0);
    currentPage = 0;
    document.getElementById('pages').innerHTML = '';
    addPage();
    tiles = pages.data[0];
    currentTile = 0;
    bakeData();
    reDrawTilemapBuffer();
  }
}

function copyToClipboard(text) {
    if (window.clipboardData && window.clipboardData.setData) {
        // IE specific code path to prevent textarea being shown while dialog is visible.
        return clipboardData.setData("Text", text); 

    } else if (document.queryCommandSupported && document.queryCommandSupported("copy")) {
        var textarea = document.createElement("textarea");
        textarea.textContent = text;
        textarea.style.position = "fixed";  // Prevent scrolling to bottom of page in MS Edge.
        document.body.appendChild(textarea);
        textarea.select();
        try {
            return document.execCommand("copy");  // Security exception may be thrown by some browsers.
        } catch (ex) {
            console.warn("Copy to clipboard failed.", ex);
            return false;
        } finally {
            document.body.removeChild(textarea);
        }
    }
}

function bakeDataMap (tiles, output) {
  if (tiles.data.length === 0) {
    return;
  }
  const name = tiles.name.toLowerCase();
  let data = '';

  for (let y = 0; y < tiles.height; ++y) {
    data += '  db ';
    for (let x = 0; x < tiles.width; ++x) {
      if (tiles.data[y] !== undefined && tiles.data[y][x] !== undefined) {
        const tile = tiles.data[y][x];
        data += toHex(tile) + (x < tiles.width - 1 ? ',' : '');
      } else {
        data += '$00' + (x < tiles.width - 1 ? ',' : '');
      }
    }
    data += '\n';
  }

  tiles.x = parseInt(document.getElementById('x').value);
  tiles.y = parseInt(document.getElementById('y').value);

  const asm = `
${name}_map_x equ ${toHex(tiles.x)}
${name}_map_y equ ${toHex(tiles.y)}
${name}_map_width equ ${toHex(tiles.width)}
${name}_map_height equ ${toHex(tiles.width)}
${name}_map_size equ ${toHex(tiles.width * tiles.height)}
${name}_map_data:
${data}
`;
  output.innerText += asm;
}

function addPage() {
  const sel = document.createElement('option');
  sel.value = currentPage;
  sel.text = `${mapNameInput.value}${currentPage}`;
  document.getElementById('pages').appendChild(sel);
  pages.data.push({ data: [], x: 0, y: 0, width: 0, height: 0, currentPage: currentPage, name: sel.text });
  currentPage += 1;
}

function loadPage (pageData) {
  const sel = document.createElement('option');
  sel.value = pageData.currentPage;
  sel.text = pageData.name;
  document.getElementById('pages').appendChild(sel);
}

function drawRectLines (ctx, x, y, width, height) {
  ctx.fillRect(x, y, width, 1);
  ctx.fillRect(x + width, y, 1, height);
  ctx.fillRect(x, y + height, width + 1, 1);
  ctx.fillRect(x, y, 1, height);
}

function drawBackEditor (ctx) {
  ctx.fillStyle = '#000';
  ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  
  ctx.drawImage(tilemapBuffer, 0, 0);

  if (cursor.state === 1) {
    ctx.drawImage(tileset, 0, 0);
    ctx.fillStyle = '#ff0000';
    ctx.globalAlpha = 0.2;
    ctx.fillRect(cursor.x, cursor.y, TILE_SIZE, TILE_SIZE);
    ctx.globalAlpha = 1.0;
  }

  {
    const sx = (currentTile % tileCountX) * TILE_SIZE;
    const sy = ((currentTile / tileCountX)|0) * TILE_SIZE;
    ctx.drawImage(tileset, sx, sy, TILE_SIZE, TILE_SIZE, editCursor.x, editCursor.y, TILE_SIZE, TILE_SIZE);
    ctx.fillStyle = '#ff0000';
    ctx.globalAlpha = 0.2;
    ctx.fillRect(editCursor.x, editCursor.y, TILE_SIZE, TILE_SIZE);
    ctx.globalAlpha = 1.0;
  }
}

function clearStorage () {
  if (confirm('Are you sure you want to clear storage?')) {
    localStorage.clear();
    clearAll(true);
    reset();
    frontBuffer.focus()
  }
}

function reDrawTilemapBuffer () {
  tilemapBufferCtx.clearRect(0, 0, tilemapBuffer.width, tilemapBuffer.height);
  for (let y = 0; y < tiles.height; ++y) {
    for (let x = 0; x < tiles.width; ++x) {
      let tile = 0;
      let sx = 0;
      let sy = 0;
      if (tiles.data[y] !== undefined && tiles.data[y][x] !== undefined) {
        tile = tiles.data[y][x];
        sx = (tile % tileCountX) * TILE_SIZE;
        sy = ((tile / tileCountX)|0) * TILE_SIZE;
      }
      tilemapBufferCtx.drawImage(tileset, sx, sy, TILE_SIZE, TILE_SIZE, x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
    }
  }
}

function placeTile (tile, x, y) {
  if (tiles.data[y] === undefined) {
    tiles.data[y] = [];
  }
  if (tiles.data[y][x] === tile) {
    tiles.data[y][x] = 0;
  }
  tiles.data[y][x] = tile;
  tiles.width = Math.max(x + 1, tiles.width);
  tiles.height = Math.max(y + 1, tiles.height);
  tilemapBuffer.width = tiles.width * TILE_SIZE;
  tilemapBuffer.height = tiles.height * TILE_SIZE;
  reDrawTilemapBuffer();
  bakeData();
  tileCount = 0;
  for (let i = 0; i < tiles.height; ++i) {
    for (let j = 0; j < tiles.width; ++j) {
      if (tiles.data[i] && tiles.data[i][j] > 0) {
        tileCount += 1;
      }
    }
  }
  document.getElementById('message').innerHTML = '';
  document.getElementById('tileCount').innerHTML = `Tile Count: ${tileCount.toString()}`;
  if (tileCount > 29) {
    document.getElementById('message').innerHTML = `Tile count exceeded by ${tileCount - 29}`;
  }
}

function handleInput () {
  cursor.state = 0;
  if (isKeyHit('KeyT')) {
    cursor.x = (currentTile % tileCountX) * TILE_SIZE;
    cursor.y = ((currentTile / tileCountX)|0) * TILE_SIZE;
  }

  if (isKeyDown('KeyT')) {
    if (mouse.moving) {
      cursor.x = Math.floor((mouse.x / TILE_SIZE)) * TILE_SIZE;
      cursor.y = Math.floor((mouse.y / TILE_SIZE)) * TILE_SIZE;
    }

    cursor.state = 1;
    if (isKeyHit('ArrowLeft')) {
      cursor.x -= TILE_SIZE;
    } else if (isKeyHit('ArrowRight')) {
      cursor.x += TILE_SIZE;
    }
    if (isKeyHit('ArrowUp')) {
      cursor.y -= TILE_SIZE;
    } else if (isKeyHit('ArrowDown')) {
      cursor.y += TILE_SIZE;
    }
    if (cursor.x < 0) cursor.x = 0;
    else if (cursor.x > tileset.width - TILE_SIZE) cursor.x = tileset.width - TILE_SIZE;
    if (cursor.y < 0) cursor.y = 0;
    else if (cursor.y > tileset.height - TILE_SIZE) cursor.y = tileset.height - TILE_SIZE;


  } else if (isKeyUp('KeyT')) {
    currentTile = (cursor.x/TILE_SIZE)|0 + tileCountX * (cursor.y/TILE_SIZE)|0;
    lastTile = currentTile;
  } else {
    let moved = false;
    if (isKeyHit('KeyE')) {
      lastTile = currentTile;
      currentTile = deleteTile;
    } else if (isKeyUp('KeyE')){
      currentTile = lastTile;
    }
    if (isKeyHit('ArrowLeft')) {
      editCursor.x -= TILE_SIZE;
      moved = true;
    } else if (isKeyHit('ArrowRight')) {
      editCursor.x += TILE_SIZE;
      moved = true;
    }
    if (isKeyHit('ArrowUp')) {
      editCursor.y -= TILE_SIZE;
      moved = true;
    } else if (isKeyHit('ArrowDown')) {
      editCursor.y += TILE_SIZE;
      moved = true;
    }
    if (editCursor.x < 0) editCursor.x = 0;
    else if (editCursor.x > LCD_WIDTH - TILE_SIZE) editCursor.x = LCD_WIDTH - TILE_SIZE;
    if (editCursor.y < 0) editCursor.y = 0;
    else if (editCursor.y > LCD_HEIGHT - TILE_SIZE) editCursor.y = LCD_HEIGHT - TILE_SIZE;
    if (isKeyHit('Space') || (moved && isKeyDown('Space'))) {
      placeTile(currentTile, (editCursor.x / TILE_SIZE)|0, (editCursor.y / TILE_SIZE)|0);
    }
    if (isKeyHit('Enter')) {
      bakeData();
    }

    if (mouse.moving) {
      editCursor.x = Math.floor((mouse.x / TILE_SIZE)) * TILE_SIZE;
      editCursor.y = Math.floor((mouse.y / TILE_SIZE)) * TILE_SIZE;
    }
    if (isMouseDown(0)) {
      placeTile(currentTile, (editCursor.x / TILE_SIZE)|0, (editCursor.y / TILE_SIZE)|0);
    }
  }
}

function drawFrontEditor (ctx) {
  ctx.save();
  ctx.scale(frontBufferScale, frontBufferScale);
  ctx.drawImage(backBuffer, 0, 0);
  ctx.restore();
}

function mainLoop () {
  requestAnimationFrame(mainLoop);
  handleInput(); 
  drawBackEditor(backBufferCtx);
  drawFrontEditor(frontBufferCtx);
}

function reset () {
  const tileData = readPixels(tileset);
  tileCountX = (tileset.width / TILE_SIZE)|0;
  tileCountY = (tileset.height / TILE_SIZE)|0;
  tilesetData.asm = '';
  tilesetData.size = (tileData.length < 0x100 ? toHex(tileData.length) : toHex16(tileData.length));
  for (let i = 0, step = 0; i < tileData.length; ++i) {
    if (step === 16 || i === 0) {
      tilesetData.asm += '\n  db ';
      step = 0;
    }
    step += 1;
    tilesetData.asm += toHex(tileData[i]) + (step < 16 ? ',' : '');
  }

  addPage();
  bakeData();
  populateLoadList();

  tiles = pages.data[0];
  tileCount = 0;
}

function start () {
  reset();

  document.getElementById('pages').addEventListener('change', (evt) => {
    const target = evt.target;
    tiles = pages.data[target.selectedIndex];
    document.getElementById('x').value = tiles.x;
    document.getElementById('y').value = tiles.y;
    reDrawTilemapBuffer();
  });
  document.getElementById('x').addEventListener('input', (evt) => {
    let val = parseInt(evt.target.value);
    val = isNaN(val) ? 0 : val;
    tiles.x = val & 0xFF;
    evt.target.value = val;
    bakeData();
  });
  document.getElementById('y').addEventListener('input', (evt) => {
    let val = parseInt(evt.target.value);
    val = isNaN(val) ? 0 : val;
    tiles.y = val & 0xFF;
    evt.target.value = val;
    bakeData();
  });
  document.getElementById('mapName').addEventListener('input', (evt) => {
    bakeData();
  });

  document.getElementById('code').addEventListener('click', (evt) => {
    if (copyToClipboard(evt.target.innerText)) {
        document.getElementById('message').innerHTML = 'COPIED!';
    } else {
        document.getElementById('message').innerHTML = 'FAILED TO COPY';
    }
      setTimeout(() => {
        document.getElementById('message').innerHTML = '';
      }, 1000);

  });

  // setTimeout(function r () {
  //   setTimeout(r,0);
  //   frontBuffer.focus();
  // }, 0);

  // window.onclick = () => {
  //   console.log('fooo');
  // }

  mainLoop();

}

tileset.crossOrigin = "Anonymous";
tileset.onload = start;
tileset.src = '../assets/spritesheet.png';
