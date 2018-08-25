const backBuffer = document.createElement('canvas');
const tileset = new Image();
const backBufferCtx = backBuffer.getContext('2d');
const frontBuffer = document.getElementById('canvas');
const frontBufferCtx = frontBuffer.getContext('2d');
const keyboard = { down: {}, hit: {}, release: {} };
const mouse = { x: 0, y: 0, down: {}, hit: {}, release: {}, moving: false };
const mapNameInput = document.getElementById('mapName');
const frontBufferScale = 2;
let currentPage = 0;
let timeout = null;

mapNameInput.value = 'sprites';

frontBuffer.width = 160 * frontBufferScale;
frontBuffer.height = 144 * frontBufferScale;
backBuffer.width = 160;
backBuffer.height = 144;
backBufferCtx.imageSmoothingEnabled = false;
frontBufferCtx.imageSmoothingEnabled = false;

function disableMouseMove () {
  clearTimeout(timeout);
  timeout = null;
  mouse.moving = false;
}

window.onkeydown = function (evt) {
  const code = evt.code;
  if (!keyboard.down[code]) {
    keyboard.hit[code] = true;
  }
  keyboard.down[code] = true;
  keyboard.release[code] = false;
};

window.onkeyup = function (evt) {
  const code = evt.code;
  keyboard.down[code] = false;
  keyboard.hit[code] = false;
  keyboard.release[code] = true;
};

frontBuffer.onmousemove = function (evt) {
  mouse.x = ((evt.clientX - frontBuffer.offsetLeft) / frontBufferScale)|0;
  mouse.y = ((evt.clientY - frontBuffer.offsetTop) / frontBufferScale)|0;
  mouse.moving = true;
  if (!timeout)
    timeout = setTimeout(disableMouseMove, 100);
};

frontBuffer.onmousedown = function (evt) {
  const button = evt.button;
  mouse.x = ((evt.clientX - frontBuffer.offsetLeft) / frontBufferScale)|0;
  mouse.y = ((evt.clientY - frontBuffer.offsetTop) / frontBufferScale)|0;
  if (!mouse.down[button]) {
    mouse.hit[button] = true;
  }
  mouse.down[button] = true;
  mouse.release[button] = false;
};

frontBuffer.onmouseup = function (evt) {
  const button = evt.button;
  mouse.x = ((evt.clientX - frontBuffer.offsetLeft) / frontBufferScale)|0;
  mouse.y = ((evt.clientY - frontBuffer.offsetTop) / frontBufferScale)|0;
  mouse.hit[button] = false;
  mouse.down[button] = false;
  mouse.release[button] = true;
};

function isKeyDown (code) {
  return !!keyboard.down[code];
}

function isKeyHit (code) {
  if (keyboard.hit[code]) {
    keyboard.hit[code] = false;
    return true;
  }
  return false;
}

function isKeyUp (code) {
  if (keyboard.release[code]) {
    keyboard.release[code] = false;
    return true;
  }
  return false;
}

function isMouseDown (button) {
  return !!mouse.down[button];
}

function isMouseHit (button) {
  if (mouse.hit[button]) {
    mouse.hit[button] = false;
    return true;
  }
  return false;
}

function isMouseUp (button) {
  if (mouse.release[button]) {
    mouse.release[button] = false;
    return true;
  }
  return false;
}
