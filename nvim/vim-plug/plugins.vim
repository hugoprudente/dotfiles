" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " vim tmux and navigations
    Plug 'christoomey/vim-tmux-navigator'
    
    " Add some color
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'ParamagicDev/vim-medic_chalk'

    " lightline - statusbar
    Plug 'itchyny/lightline.vim'
    
    " sneak
    Plug 'justinmk/vim-sneak'

    " devicons
    Plug 'ryanoasis/vim-devicons'

    " startify
    Plug 'mhinz/vim-startify'

    " code 
    Plug 'pearofducks/ansible-vim'
    Plug 'hashivim/vim-vagrant'
    Plug 'lepture/vim-jinja'
    Plug 'cespare/vim-toml'
    Plug 'hashivim/vim-terraform'

    " coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
