import { app, screen } from "electron";
import path from "path";
import fs from "fs";

const windowStorage = path.join(app.getPath("userData"), "window.json");

export function init(window) {

  // Restore window position and size if available
  let { x, y, width, height, fullscreen } = { x: undefined, y: undefined, width: 1000, height: 800, fullscreen: false };
  try { ({ x, y, width, height, fullscreen } = JSON.parse(fs.readFileSync(windowStorage))) } catch (e) { }

  // Check if window is offscreen
  if (x || y) {
    const screens = screen.getAllDisplays();

    // Reset position as app header is completely offscreen
    if (screens.every(({ bounds }) => x + width < bounds.x || bounds.x + bounds.width < x || y < bounds.y || bounds.y + bounds.height < y)) {
      x = undefined;
      y = undefined;

      width = 1000;
      height = 800;
    }
  }

  // Center at main screen if no position is set
  if (!x || !y) {
    const primary = screen.getPrimaryDisplay();

    x = primary.bounds.x + primary.bounds.width / 2 - width / 2;
    y = primary.bounds.y + primary.bounds.height / 2 - height / 2;
  }

  // Set position and wait for event to add listeners
  window.setBounds({ x, y, width, height });
  window.once("show", () => { setTimeout(() => { fullscreen ? window.maximize() : window.unmaximize() }, 250) });

  window.once("ready-to-show", () => {

    // Save window state to prevent data loss on unexpected closure
    const saveWindowStateDebounced = (() => {
      let timeout;

      return () => {
        clearTimeout(timeout);
        timeout = setTimeout(() => { fs.writeFileSync(windowStorage, JSON.stringify({ x, y, width, height, fullscreen })) }, 250);
      }
    })();

    // Handle all important window events
    ["resize", "move"].forEach(event => window.on(event, () => { ({ x, y, width, height } = window.getNormalBounds()); saveWindowStateDebounced() }));
    ["maximize", "unmaximize"].forEach(event => window.on(event, () => { fullscreen = window.isMaximized(); saveWindowStateDebounced() }));
  });
}
