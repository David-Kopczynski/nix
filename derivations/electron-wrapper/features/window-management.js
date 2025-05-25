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

  // Set position and wait for event to add listeners
  window.setBounds({ x, y, width, height });
  window.once("show", () => { setTimeout(() => { fullscreen ? window.maximize() : window.unmaximize() }, 250) });

  window.once("ready-to-show", () => {

    // Handle all important window events
    ["resize", "move"].forEach(event => window.on(event, () => { ({ x, y, width, height } = window.getNormalBounds()) }));
    ["maximize", "unmaximize"].forEach(event => window.on(event, () => { fullscreen = window.isMaximized() }));

    // Store window position and size on close
    window.on("close", () => { fs.writeFileSync(windowStorage, JSON.stringify({ x, y, width, height, fullscreen })) });
  });
}
