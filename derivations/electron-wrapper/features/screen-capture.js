import { desktopCapturer, dialog, session } from "electron";

export function init(window) {

  // Handle desktop capture
  session.defaultSession.setDisplayMediaRequestHandler(async (_, callback) => {

    // Show window picker to select source
    const sources = await desktopCapturer.getSources({ types: ["screen"] });

    const selection = await dialog.showMessageBox(window, {
      type: "question",
      title: "Select Screen",
      message: "Please select the screen you want to share.",
      buttons: ["Cancel", ...sources.map(({ name }) => name)],
      defaultId: 0
    });

    if (selection.response) {
      const source = sources[selection.response - 1];
      callback({ video: source });
    }
    else
      callback(null);

  }, { useSystemPicker: true });
}
