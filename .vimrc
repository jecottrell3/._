:set scrolloff=4
:set ignorecase
:set hlsearch
:set incsearch
:set bg=light
:set tags+=tags;

if &diff
	:map \		:diffupdate<CR>
	:colorscheme evening
else
	:map \		:n<CR>
	:colorscheme default
	:colorscheme peachpuff
	:colorscheme murphy
endif

:highlight Search ctermfg=3 ctermbg=4 cterm=bold
:highlight Search ctermfg=3 ctermbg=1 cterm=bold
:highlight Search ctermfg=4 ctermbg=6 cterm=bold
:highlight Search ctermfg=6 ctermbg=4 cterm=bold

:map <C-_>	:se nu!<CR>

