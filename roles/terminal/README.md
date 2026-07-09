# Terminal Emulator Configuration

## iTerm2 (macOS)

The iTerm2 configuration is partially automated, but some manual steps are
required due to application limitations.

### Manual steps

The following steps must be performed manually after the playbook runs:

**1. Import the custom profile**

1. iTerm2 > **Preferences** > **Profiles**;
2. Open the **Other Actions...** drop-down in the bottom left corner;
3. Select **Import JSON Profiles...** from the list;
4. Select the `DenisCosta.json` file;
5. Select **DenisCosta** from the Profiles list;
6. Set it as default in the same dropdown below.

**2. Apply the Dracula color theme**

1. iTerm2 > **Preferences** > **Profiles** > **Colors Tab**;
2. Open the **Color Presets...** drop-down in the bottom right corner;
3. Select **Import...** from the list;
4. Select the `Dracula.itermcolors` file;
5. Select **Dracula** from **Color Presets**.

### Key bindings

The iTerm2 profile includes custom key mappings for improved text editing:

| Shortcut | Action |
|----------|--------|
| `⌥ (Option) + ←` | Move cursor backward by word |
| `⌥ (Option) + →` | Move cursor forward by word |
| `⌘ (Command) + ←` | Move cursor to beginning of line |
| `⌘ (Command) + →` | Move cursor to end of line |
| `⌥ (Option) + Delete` | Delete word to the left |
| `⌘ (Command) + Delete` | Delete from cursor to beginning of line |
| `⌥ (Option) + Del (Fn Delete)` | Delete character to the right (forward delete) |

These bindings align the terminal behavior with native macOS text editing
shortcuts found in other applications.

## Terminator (Linux)

**TODO**
