// Reads Caps Lock out of `hyprctl -j devices`. Kept free of QML so it can be
// tested with node.

// Hyprland keeps lock state per keyboard, and only the keyboard that turned
// Caps Lock on reports it, so any keyboard reporting it counts. Returns null
// when the text is not a device list, so the caller keeps its last reading.
function capsOn(text) {
  var keyboards
  try {
    keyboards = JSON.parse(text).keyboards
  } catch (e) {
    return null
  }
  if (!Array.isArray(keyboards)) return null
  return keyboards.some(function (k) { return k.capsLock === true })
}

if (typeof module !== "undefined") module.exports = { capsOn: capsOn }
