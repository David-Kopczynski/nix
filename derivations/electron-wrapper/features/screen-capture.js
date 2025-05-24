import { desktopCapturer, session } from "electron";

export function init(_) {

  // Handle desktop capture
  session.defaultSession.setDisplayMediaRequestHandler(async (_, callback) => {

    // Show window picker to select source
    const sources = await desktopCapturer.getSources({ types: ["window", "screen"] });
    callback(sources.length ? { video: sources[0] } : null);

  }, { useSystemPicker: true });
}
