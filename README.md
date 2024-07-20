### About the plugin

The aim of this plugin is to capture the clipboard history and provide a way to browse through the recently yanked items,
be it on the system clipboard or the VIM clipboard(The 2 are different)

The selection registers are the bridge to connect Vim and the system clipboard. Vim has two selection registers: `* and +`
We will be utilizing these registers to capture and modify the clipboard history.

### Functionality Roadmap

- [x] Capture the clipboard history
- [ ] Save the clipboard history to persistant storage
- [x] Browse through the clipboard history
- [ ] Select item in the clipboad history to yank them back to the clipboard
- [ ] Delete items from the clipboard history
- [ ] Provide configuration and limit the number of items in the clipboard history
- [ ] Provide a way to search through the clipboard history
- [ ] Support multi line clipboard items to be yanked as one
