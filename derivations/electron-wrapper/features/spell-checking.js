import { Menu, MenuItem } from "electron";

export function init(window) {

  // Enable spell checking
  window.webContents.session.setSpellCheckerLanguages(["en-US", "de-DE"]);

  // Handle context menu for spell checking
  window.webContents.on("context-menu", (_, params) => {

    if (params.misspelledWord) {
      const menu = new Menu();

      // Add spelling suggestions to context menu
      for (const suggestion of params.dictionarySuggestions) {
        menu.append(new MenuItem({
          label: suggestion,
          click: () => window.webContents.replaceMisspelling(suggestion)
        }));
      }

      menu.append(new MenuItem({ type: "separator" }));

      menu.append(new MenuItem({
        label: "Add to dictionary",
        click: () => window.webContents.session.addWordToSpellCheckerDictionary(params.misspelledWord)
      }));

      menu.popup();
    }
  });
}
