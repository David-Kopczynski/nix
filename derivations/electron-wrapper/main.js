import { app, BrowserWindow } from "electron";

app.on("ready", () => {

  // Spawn main window
  const window = new BrowserWindow({
    title: process.env.NAME,
    minWidth: 800, minHeight: 600,
    autoHideMenuBar: true,
    show: false,
    transparent: true,
    backgroundColor: "#00000000",
    webPreferences: {
      contextIsolation: true,
      nodeIntegration: false
    }
  });

  // Load provided URL
  window.loadURL(process.env.URL, { userAgent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36" });

  // Show window when ready
  // Wait for short time to allow page to load in
  window.once("ready-to-show", () => setTimeout(() => window.show(), 500));

  // Init all features
  Promise.all([
    import("./features/external-urls.js"),
    import("./features/screen-capture.js"),
    import("./features/spell-checking.js"),
    import("./features/window-management.js")
  ])
    .then((features) => features.forEach(({ init }) => init(window)));
});
