# quickpick-files.vim
Files picker for [quickpick.vim](https://github.com/prabirshrestha/quickpick.vim).

## Install
```vim
Plug 'prabirshrestha/quickpick.vim'
Plug 'clozed2u/quickpick-files.vim'
```

## Finder
By default `quickpick-files.vim` use [fd](https://github.com/sharkdp/fd) as a finder command, so you need `fd` command in your `$PATH`.

You can override finder command by set `g:quickpick_files_command` variable to your prefer command, for example if you want to use [rg](https://github.com/BurntSushi/ripgrep) instead of [fd](https://github.com/sharkdp/fd) you can put line below into your vim config

```vim
let g:quickpick_files_command = 'rg --files'
```

## Usage
```vim
:Pfiles
```
