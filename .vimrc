" Compiling Vim:
" ./configure --enable-pythoninterp
"             --enable-rubyinterp
"             --with-ruby-command=/usr/bin/ruby
"             --with-features=huge

" Plugins: {{{
  " Setup: {{{
    let mapleader = ","
    set nocompatible
    filetype off
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
  " }}}-----------------------------------------------------------------------
  " Common: {{{
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'ayu-theme/ayu-vim'
    Plugin 'tpope/vim-dispatch'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'Vimjas/vim-python-pep8-indent'
    Plugin 'will133/vim-dirdiff'
    Plugin 'tpope/vim-eunuch'

    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    nnoremap <leader>t :Files<cr>

    Plugin 'maxmellon/vim-jsx-pretty'


    Plugin 'vim-syntastic/syntastic'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let b:syntastic_mode = 'passive'
    let g:syntastic_ocaml_checkers = ['merlin']
    nnoremap <leader>s :SyntasticToggleMode<cr>

    Plugin 'mileszs/ack.vim'
    let g:ack_use_dispatch = 1
    nnoremap <leader>a :Ack!


    Plugin 'tpope/vim-fugitive'
    nnoremap <leader>gb :Git blame<cr>
    nnoremap <leader>gs :Gstatus<cr>

    Plugin 'dhruvasagar/vim-table-mode'
    let g:table_mode_map_prefix = "<leader>m"
  " }}}-----------------------------------------------------------------------
  " Lisp Features: {{{
    if exists("$VIM_LISP")
      Plugin 'guns/vim-sexp'
      let g:sexp_enable_insert_mode_mappings = 0

      Plugin 'kovisoft/slimv'
      let g:slimv_swank_cmd = "(echo '(load \"~/.vim/bundle/slimv/slime/start-swank.lisp\")' && cat) | sbcl"
      "let g:slimv_swank_cmd = "(echo ':q\n(load \"~/.vim/bundle/slimv/slime/start-swank.lisp\")' && cat) | acl2s"
      "let g:slimv_swank_cmd = "!tmux new-window -d -n REPL-SBCL \"(echo ':q\\\n(load \\\"~/.vim/bundle/slimv/slime/start-swank.lisp\\\")\\\n(lp)' && cat) | acl2s\""
      "let g:slimv_swank_cmd = "!tmux new-window -d -n REPL-SBCL \"(echo ':q\\\n(load \\\"~/.vim/bundle/slimv/slime/start-swank.lisp\\\")' && cat) | acl2s\""
      let g:slimv_keybindings=0
      let g:slimv_repl_simple_eval=0
      nnoremap <leader>c :call SlimvConnectServer()<cr>
      nmap <C-m> :<C-u>call SlimvEvalDefun()<cr>]]
      nnoremap <leader>( :<C-u>call PareditToggle()<cr>
      nunmap <cr>

      Plugin 'jpalardy/vim-slime'
      let g:slime_target = "tmux"
      let g:slime_no_mappings = 1
      let g:slime_dont_ask_default = 1
      let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
      nmap <leader>lk <Plug>SlimeLineSend +
      nmap <leader>ll vaF:SlimeSend<cr>]]
      nmap <c-n> vaF:SlimeSend<cr>]]
      nmap <leader>lv <Plug>SlimeConfig
      nmap <leader>lu :SlimeSend1 :u<cr>
      nmap <leader>lw :SlimeSend1 (load "~/.vim/bundle/slimv/slime/start-swank.lisp")<cr>
      vmap <leader>l :SlimeSend<cr>
    endif
  " }}}-----------------------------------------------------------------------
  " OCaml Features: {{{
    if exists("$VIM_OCAML")
      Plugin 'let-def/ocp-indent-vim'

      let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
      execute "set rtp+=" . g:opamshare . "/merlin/vim"
    endif
    " }}}
    " TeX Features: {{{
      if exists("$VIM_TEX")
        Plugin 'lervag/vimtex'
        let g:vimtex_compiler_latexmk = {
              \ 'backend' : 'jobs',
              \ 'background' : 0,
              \ 'callback' : 0,
              \ 'continuous' : 0,
              \ 'options' : [
              \   '-pdf',
              \   '-verbose',
              \   '-file-line-error',
              \   '-synctex=1',
              \   '-interaction=nonstopmode',
              \ ],
              \}
        let g:Tex_EnvironmentMaps = 0
        let g:Tex_FontMaps = 0
        let g:Tex_SectionMaps = 0
      endif
  " }}}-----------------------------------------------------------------------
  call vundle#end()
  filetype plugin indent on
" }}}
" Global Settings: {{{
  set encoding=utf-8
  " Cosmetic: {{{
    " Info: {{{
      set ruler
      set cursorline
      set laststatus=2
      set number
      set relativenumber
      autocmd BufEnter * set relativenumber
      autocmd BufLeave * set norelativenumber
      " Cursor bar in insert mode
      let &t_SI = "\e[6 q"
      let &t_EI = "\e[2 q"
    " }}}
    " Colors: {{{
      syntax on
      set termguicolors
      if exists('$TMUX')
        let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
        let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
      endif
      let ayucolor = "dark"
      colorscheme ayu
      hi! VertSplit guifg=#2D3640
      hi! LineNr    guifg=#3E4B59
    " }}}
    set foldmethod=indent
    set nofoldenable
    set showmatch
    set lazyredraw
    " Disable the stupid beeping
    set visualbell
    set t_vb=
  " }}} ----------------------------------------------------------------------
  " Editing: {{{
    set backspace=indent,start
  " }}} ----------------------------------------------------------------------
  " Panes: {{{
    set splitright
    set splitbelow
  " }}} ----------------------------------------------------------------------
  " Whitespace: {{{
    set expandtab
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set list
    set listchars=tab:>\ ,trail:·
    set fillchars=vert:│
    hi SpecialKey ctermfg=4
  " }}}
  " Search: {{{
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
  " }}}
" }}}
" Global Bindings: {{{
  nnoremap <leader><space> :nohlsearch<cr>
  nnoremap <leader>q :cclose<cr>
  nnoremap <leader>f :set foldenable<cr>

  " File Navigation: {{{
    nnoremap <leader>ee :Explore<cr>
    nnoremap <leader>er :Rexplore<cr>
    nnoremap <leader>ev :Vexplore<cr>
    nnoremap <leader>eh :Sexplore<cr>
    nnoremap <leader>et :Texplore<cr>
  " }}}
  " Clipboard: {{{
    " Perl voodoo to strip the newline before copying to OSX clipboard
    " I should adapt this to Linux
    vnoremap <C-y> y:new ~/vim_clip<cr>VGp:w<cr>:bd<cr>:!perl -pe 'chomp if eof' ~/vim_clip \| pbcopy<cr><cr>
    nnoremap <C-p> :read ~/vim_clip<cr>
    nnoremap <leader>p :set invpaste<cr>
  " }}}
  " Vimrc: {{{
    nnoremap <leader>ve :vsplit $MYVIMRC<cr>
    nnoremap <leader>vt :tabe $MYVIMRC<cr>
    nnoremap <leader>vs :source $MYVIMRC<cr>
  " }}}
  " Movement: {{{
    set mouse=a
    if !has('nvim')
      set ttymouse=xterm2
    endif
    " <M-j>
    noremap ∆ j<C-e>
    " <M-k>
    noremap ˚ k<C-y>
    inoremap <C-h> <left>
    inoremap <C-j> <down>
    inoremap <C-k> <up>
    inoremap <C-l> <right>
    inoremap <ScrollWheelUp> <nop>
    inoremap <ScrollWheelDown> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
  " }}}
  " Panes: {{{
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
  " }}}
  " Tabs: {{{
    nnoremap g1 1gt
    nnoremap g2 2gt
    nnoremap g3 3gt
    nnoremap g4 4gt
    nnoremap g5 5gt
    nnoremap g6 6gt
    nnoremap g7 7gt
    nnoremap g8 8gt
    nnoremap g9 9gt
    nnoremap <C-q> :tabclose<cr>
  " }}}
  " Editing: {{{
    inoremap jk <esc>
    nnoremap - ddp
    nnoremap _ ddkP
    nnoremap <tab> cc
  " }}}
" }}}
" Filetype Settings: {{{
  " Vim: {{{
    augroup filetype_vim
      autocmd!
      autocmd FileType vim setlocal foldmethod=marker
    augroup END
  " }}}
  " Ruby: {{{
    augroup filetype_ruby
      autocmd!
      autocmd FileType ruby noremap <buffer> <localleader>i obyebug<esc>^
    augroup END
    autocmd BufNewFile,BufRead *.arb set filetype=ruby
  " }}}
  " Python: {{{
    augroup filetype_python
      autocmd!
      autocmd FileType python noremap <buffer> <localleader>i oimport ipdb; ipdb.set_trace()<esc>^
      autocmd FileType python setlocal textwidth=100
      autocmd FileType python setlocal shiftwidth=4
    augroup END
  " }}}
  " TeX: {{{
    autocmd BufNewFile,BufRead *.tex set filetype=plaintex
  " }}}
  " Lisp: {{{
    augroup filetype_lisp
      autocmd!
      autocmd FileType lisp :highlight executed guibg=#222222
      set lispwords+=defunc,definec,match,defrule,deftest,defthm
      "autocmd FileType lisp nmap <leader>lm :match executed /\%<<C-r>=line('.')<cr>l/<cr>
    augroup END
  " }}}
  " OCaml: {{{
    augroup filetype_ocaml
      autocmd!
      autocmd FileType ocaml nnoremap <buffer> <localleader>m :MerlinTypeOf<cr>
    augroup END
  " }}}
" }}}
