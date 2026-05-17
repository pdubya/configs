# Dotfiles — Claude Context

## Environment
- **OS**: Pop!_OS 24
- **Terminal**: Kitty — config at `kitty/kitty.conf`
- **Shell**: zsh + Oh My Zsh, theme `imajes`, config at `zsh/.zshrc`
- **Editor**: Neovim 0.12.2 installed at `/opt`, config at `nvim/init.lua`, using built-in `vim.pack` package manager
- **Neovim plugins** (all in `~/.local/share/nvim/site/pack/core/opt/`): mason.nvim, ctrlp.vim, nvim-web-devicons, lualine.nvim, julia-vim, vim-kitty-navigator

## Symlinks required after a fresh clone

This repo lives at `~/.config`. Kitty and Neovim configs are at their standard XDG paths already, but zsh needs a symlink:

```sh
ln -sf ~/.config/zsh/zshrc ~/.zshrc
```

## Known fixes

### Nerd Font symbols (e.g. Julia filetype icon in lualine) showing as kanji
JetBrainsMono Nerd Font is not installed — Kitty falls back to a CJK font for the Nerd Font Private Use Area.
Fix in `kitty/kitty.conf`: install `Symbols Nerd Font Mono` (symbols-only font) and add:
```
symbol_map U+E000-U+F8FF,U+F0000-U+FFFFF Symbols Nerd Font Mono
```

### Backspace doubles in Neovim cmdline mode
Neovim 0.12 enables the Kitty Keyboard Protocol (KKP) before any config loads — present even with `nvim -u NONE`. KKP sends both key-press and key-release events; Neovim 0.12 processes both as deletions in cmdline mode.
Fix in `kitty/kitty.conf`:
```
map backspace send_text all \x7f
```
`send_text` bypasses KKP entirely, injecting one raw `\x7f` per keypress.
