function wave(steps, scale, startFunc, endFunc) {
  const result = [];
  let i = 0;
  for (i = 0; i < (steps / 2)|0; i += 1) {
    const n = i / (steps);
    result.push((startFunc(n) * scale)|0);
  }
  for (; i > (-1); i -= 1) {
    const n = i / (steps);
    result.push((endFunc(n) * scale)|0);
  }
  return result;
}

const anim = {};

anim.linear = function (n) {
  return n;
};
anim.easeInQuad = function (n) {
  return n * n;
};
anim.easeIn = anim.easeInQuad;
anim.easeOutQuad = function (n) {
  return n * (2 - n);
};
anim.easeOut = anim.easeOutQuad;
anim.easeInOutQuad = function (n) {
  if ((n *= 2) < 1) { return 0.5 * n * n; }
  return -0.5 * (--n * (n - 2) - 1);
};
anim.easeInCubic = function (n) {
  return n * n * n;
};
anim.easeOutCubic = function (n) {
  return (n -= 1) * n * n + 1;
};
anim.easeInOutCubic = function (n) {
  if ((n *= 2) < 1) { return 0.5 * n * n * n; }
  return 0.5 * ((n -= 2) * n * n + 2);
};
anim.easeInOut = anim.easeInOutCubic;
anim.easeInQuart = function (n) {
  return n * n * n * n;
};
anim.easeOutQuart = function (n) {
  return -1 * ((n -= 1) * n * n * n - 1);
};
anim.easeInOutQuart = function (n) {
  if ((n *= 2) < 1) { return 0.5 * n * n * n * n; }
  return -0.5 * ((n -= 2) * n * n * n - 2);
};
anim.easeInQuint = function (n) {
  return n * n * n * n * n;
};
anim.easeOutQuint = function (n) {
  return (n -= 1) * n * n * n * n + 1;
};
anim.easeInOutQuint = function (n) {
  if ((n *= 2) < 1) { return 0.5 * n * n * n * n * n; }
  return 0.5 * ((n -= 2) * n * n * n * n + 2);
};
anim.easeInSine = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return -1 * Math.cos(n * (Math.PI / 2)) + 1;
};
anim.easeOutSine = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return Math.sin(n * (Math.PI / 2));
};
anim.easeInOutSine = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return -0.5 * (Math.cos(Math.PI * n) - 1);
};
anim.easeInExpo = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return n == 0 ? 0 : Math.pow(2, 10 * (n - 1));
};
anim.easeOutExpo = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return n == 1 ? 1 : -Math.pow(2, -10 * n) + 1;
};
anim.easeInOutExpo = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  if ((n *= 2) < 1) { return 0.5 * Math.pow(2, 10 * (n - 1)); }
  return 0.5 * (-Math.pow(2, -10 * --n) + 2);
};
anim.easeInCirc = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return -1 * (Math.sqrt(1 - n * n) - 1);
};
anim.easeOutCirc = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  return Math.sqrt(1 - (n -= 1) * n);
};
anim.easeInOutCirc = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  if ((n *= 2) < 1) { return -0.5 * (Math.sqrt(1 - n * n) - 1); }
  return 0.5 * (Math.sqrt(1 - (n -= 2) * n) + 1);
};
anim.easeInElastic = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  var p = 0.3;
  var s = 0.075;
  // p / (2 * Math.PI) * Math.asin(1)
  return -(Math.pow(2, 10 * (n -= 1)) * Math.sin((n - s) * (2 * Math.PI) / p));
};
anim.easeOutElastic = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  var p = 0.3;
  var s = 0.075;
  // p / (2 * Math.PI) * Math.asin(1)
  return Math.pow(2, -10 * n) * Math.sin((n - s) * (2 * Math.PI) / p) + 1;
};
anim.easeInOutElastic = function (n) {
  if (n == 0) { return 0; }
  if ((n *= 2) == 2) { return 1; }
  var p = 0.45;
  // 0.3 * 1.5
  var s = 0.1125;
  // p / (2 * Math.PI) * Math.asin(1)
  if (n < 1) {
    return -0.5 * (Math.pow(2, 10 * (n -= 1)) * Math.sin((n * 1 - s) * (2 * Math.PI) / p));
  }
  return Math.pow(2, -10 * (n -= 1)) * Math.sin((n * 1 - s) * (2 * Math.PI) / p) * 0.5 + 1;
};
anim.easeInBack = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  var s = 1.70158;
  return n * n * ((s + 1) * n - s);
};
anim.easeOutBack = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  var s = 1.70158;
  return (n -= 1) * n * ((s + 1) * n + s) + 1;
};
anim.easeInOutBack = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  var s = 1.70158;
  if ((n *= 2) < 1) { return 0.5 * (n * n * (((s *= 1.525) + 1) * n - s)); }
  return 0.5 * ((n -= 2) * n * (((s *= 1.525) + 1) * n + s) + 2);
};
anim.easeOutBounce = function (n) {
  if (n == 0) { return 0; }
  if (n == 1) { return 1; }
  if (n < 1 / 2.75) {
    return 7.5625 * n * n;
  } else if (n < 2 / 2.75) {
    return 7.5625 * (n -= 1.5 / 2.75) * n + 0.75;
  } else if (n < 2.5 / 2.75) {
    return 7.5625 * (n -= 2.25 / 2.75) * n + 0.9375;
  } else {
    return 7.5625 * (n -= 2.625 / 2.75) * n + 0.984375;
  }
};
anim.easeInBounce = function (n) {
  return 1 - anim.easeOutBounce(1 - n);
};
anim.easeInOutBounce = function (n) {
  if (n < 0.5) { return anim.easeInBounce(n * 2) * 0.5; }
  return anim.easeOutBounce(n * 2 - 1) * 0.5 + 0.5;
};

console.log(wave(31, 144, anim.linear, anim.linear).toString());