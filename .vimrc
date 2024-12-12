:set scrolloff=4
:set ignorecase
:set hlsearch
:set incsearch
:set bg=light
:set tags+=tags;

:map <C-\>		<C-w>w
:map <C-k>a		:args<CR>
:map <C-k>c		:colorscheme<SPACE>
:map <C-k>g		:g/
:map <C-k>p		:g//p<CR>
:map <C-k>s		:%s/
:map <C-k>h		:help<SPACE>
:map <C-k>r		:rewind<CR>
:map <C-k>t		:diffthis<CR>
:map <C-k>u		:diffupdate<CR>
:map <C-k>n		:n<CR>
:map <C-k>w		:wn<CR>

if &diff
"	:map \		:diffupdate<CR>
	:colorscheme evening
else
"	:map \		:n<CR>
	:colorscheme default
	:colorscheme peachpuff
	:colorscheme murphy
endif

:highlight Search ctermfg=3 ctermbg=4 cterm=bold
:highlight Search ctermfg=3 ctermbg=1 cterm=bold
:highlight Search ctermfg=4 ctermbg=6 cterm=bold
:highlight Search ctermfg=6 ctermbg=4 cterm=bold

:map <C-_>	:se nu!<CR>

