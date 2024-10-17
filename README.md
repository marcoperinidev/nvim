> [!CAUTION]
> Inspired by ThePrimeAgen and Joesan.<br>
> [Joesan Complete Neovim Setup Guide](https://youtu.be/6pAG3BHurdM)<br>
> [PrimeAgen Nvim Playlist](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)<br>
> [PrimeAgen 0 to LSP](https://youtu.be/w7i4amO_zaE?si=v4uEn3UEa4bAf2T8)

> [!TIP]
> **If you clone the repo into your machine and use the config by copying .config/nvim to your home folder, wait for the plugins, language servers and parsers to install with lazy.nvim, Mason and nvim-treesitter.<br>If you are opening a lua file or another file I have language servers configured for, like html, css or javascript/typescript, you might also get an error saying that the server failed to start. This is because Mason hasn't installed it yet. Press enter to continue, Mason will automatically install it.**

> [!NOTE]
> If you clone it as, is some additional packages has to be intalled but you can see what is missing in the status-bar as you start NeoVim 

## Installation
> [!WARNING]
> Linux only. I don't care about Windows and SoyDevOS
```bash
git clone --depth 1 https://github.com/marcoperinidev/nvim.git ~/.config/nvim && rm ~/.config/nvim/README.md && nvim
```
### Requirements
- True Color Terminal: check True Color Terminal [here](https://gist.github.com/kurahaupo/6ce0eaefe5e730841f03cb82b061daa2). (I use [Kitty](https://sw.kovidgoyal.net/kitty/binary/))
- [Neovim](https://neovim.io/) (version 0.9 or later)
- [Nerd Font](https://www.nerdfonts.com/) I use MesloLG
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope Fuzzy Finder
- [Python/pip](https://packaging.python.org/en/latest/tutorials/installing-packages/)
- [node/npm](https://nodejs.org/en/download/package-manager) if you wanna use js/ts language server.
#
## Installation Instructions
### Now switched to Teminator but just leave Kitty for those who prefer
  > **Kitty:**
  > ```bash
  > curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  > ```

**Terminator**
```bash
sudo apt install terminator # ubuntu-like
```
```bash
yay -Syy terminator-git # Arch
```

**Nerd Font:**
```bash
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip -o ~/Downloads/Meslo.zip && mkdir -p ~/.fonts && unzip ~/Downloads/Meslo.zip -d ~/.fonts && fc-cache -v
```
#
**NeoVim:**
> <u>How to install it's really up to you.</u>
> #### Pre-build archive
> ```bash
> curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
> sudo rm -rf /opt/nvim
> sudo tar -C /opt -xzf nvim-linux64.tar.gz
> echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc # if you're using bash
> # OR
> echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc # if you're using zsh
> source ~/.bashrc # for bash shell
> source ~/.zshrc # for zsh shell
> ```
> #### Appimage
> - Follow [THIS](https://github.com/neovim/neovim/blob/master/INSTALL.md#appimage-universal-linux-package)
> #### Package Manager
> - Choose the right one for you [HERE](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
> </br>
> </br>

##

**Ripgrep:**
It depends on your specific system. See [HERE](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)

**Node/Npm:**(I suggest NVM)
```bash
# installs NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# download and install Node.js
nvm install 20

# verifies the right Node.js version is in the environment
node -v # should print `v20.12.2`

# verifies the right NPM version is in the environment
npm -v # should print `10.5.0`
```
## Plugins

#### Plugin Manager

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Amazing plugin manager

#### Dependency For Other Plugins

- [nvim-lua/plenary](https://github.com/nvim-lua/plenary.nvim) - Useful lua functions other plugins use

#### Preferred Colorscheme

- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - tokyonight colorscheme (I modified some colors it in config)

#### Navigating Between Neovim Windows and Tmux

- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - navigate b/w nvim splits & tmux panes with CTRL+h,j,k,l

#### Essentials

- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) - manipulate surroundings with "ys", "ds", and "cs"
- [gbprod/substitute.nvim](https://github.com/gbprod/substitute.nvim) - replace things with register with "s" and "S"

#### File Explorer

- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

#### VS Code Like Icons

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

#### Neovim Greeter

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) -- neovim greeter on startup

#### Auto Sessions

- [rmagatti/auto-session](https://github.com/rmagatti/auto-session) - auto save neovim sessions/restore with keymap

#### Statusline

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Better statusline

#### Bufferline

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Better looking tabs

#### Keymap Suggestions

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - Get suggested keymaps as you type

#### Fuzzy Finder

- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - Dependency for better performance
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy Finder
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - select/input ui improvement

#### Autocompletion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion plugin
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Completion source for text in current buffer
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - Completion source for file system paths
- [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) - Vs Code Like Icons for autocompletion

#### Snippets

- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Useful snippets for different languages
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Completion source for snippet autocomplete

#### Managing & Installing Language Servers, Linters & Formatters

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Install language servers, formatters and linters

#### LSP Configuration

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridges gap b/w mason & lspconfig
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Easy way to configure lsp servers
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - Smart code autocompletion with lsp

#### Trouble.nvim

- [folke/trouble.nvim](https://github.com/folke/trouble.nvim) - nice way to see diagnostics and other stuff

#### Formatting & Linting

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Easy way to configure formatters
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) - Easy way to configure linters
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto install linters & formatters on startup

#### Comments

- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) - toggle comments with "gc"
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Requires treesitter
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - highlight/search for comments like todo/hack/bug

#### Treesitter Syntax Highlighting, Autoclosing & Text Objects

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter configuration
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter configuration
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autoclose brackets, parens, quotes, etc...
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Autoclose tags

#### Indent Guides

- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides with treesitter integration

#### Git

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show modifications on left hand side and interact with git hunks
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) - Use lazygit within Neovim

