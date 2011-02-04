:help thing
	x	normal cmd
	v_x	visual mode cmd
	i_x	insert mode cmd
	:x	colon cmd
	c_x	cmd line editing
	-x	option
	'var'	variable

1.1
	^]	jump to (next) tag
	^O	jump prev tag (out)
	^I	jump next tag (in)
	^T	jump to older tag
2.2
	#i	insert
	:set	showmode
2.3
	#hjkl	<v^> also arrows
	#^h^j	left, down
2.4
	#x	delete char
	#dd	delete line
	#J	join line
2.5
	u	undo
	U	undo line
	^R	redo
2.6
	#a	append
	#o	open line below
	#O	open line above
2.7
	ZZ	exit
3.1
	#w,W	word fwd
	#b,B	word bwd
	#e,E	end  fwd
	#ge,gE	end  bwd
3.2
	0	beg line
	#^	beg line nonblank
	#$	end line
3.3
	#fx	find fwd
	#Fx	find bwd
	#tx	upto fwd
	#Tx	upto bwd
	#;	find next
	#,	find prev
3.4
	%	match (next) delimiter
	:set mps+=L:R to pair L and R
	:set mps+=<:> for html
3.5
	gg	goto beg file
	G	goto end file
	#G	goto line
	#H	screen head
	M	screen middle
	#L	screen last
3.6
	:set (no)nu*mber
	:set (no)ruler
3.7
	^D	scroll dn half page
	^U	scroll up half page
	#^E	expose line up
	#^Y	expose line dn
3.8
	/str	search fwd
	?str	search bwd
	n,N	next fwd,bwd
	:set (no)ignorecase (ic)
	UP and DN move thru history
	:set -hlsearch (hs?)
	:nohlsearch	remove highlight
	:set -incsearch	incremental
3.9
	search patterns
3.10
	mx	mark set
	`x	goto mark x char
	'x	goto mark x line
	`	mark: last jump
	"	mark: last edit
	[,]	mark: last change beg,end
	*	mark: clipboard (copy/paste)
4.1,4.2
	d<>	delete operator
	D	d$
	dd	delete line
	x,X	dl,dh
	c<>	change operator
	C	c$
	cc	change line
	s,S	cl,cc
	rx	replace character
	R	replace mode
4.3
	.	repeat last change
4.4
	v,V,^V	visual char,line,block mode
	o,O	other corner diag,horz
4.5
	"xp,P	put after,before
4.6
	"xy<>	yank motion
	"xyy	yank line
4.7
	"*	clipboard (cut/paste)
4.8
	text objects for operators
	aw,iw	a word, in word
	as,is	a sentence, in sentence
4.9
	R	replace mode
	INSERT	toggle replace mode
4.10
	~	case flip
	I	0i
	A	$a
5.1,5.2
	~/.vimrc	initial commands
	set var		variable sets
5.3
	:map from to	remap keys
		<F5>	keys
		<Esc>	Escape
		<CR>	Return
		<C-A>	^A
5.4
	:filetype plugin on/off
5.5
	plugins
5.6
	:options	interactive editor
5.7
	various options
6.1
	^L			redraw
	:syntax enable		enable color mode
	:syntax reset		resync
6.2
	:set filetype[=type]	set mode
	:set background=light	or dark
	# vim: syntax=type	in files
6.3
	:colorscheme scheme
	:highlight Type term= cterm= cterm[fg]= gui= gui[fb]g=
		attributes: none, bold, reverse, underline
6.4
	:syntax clear	temporary
	:syntax off	permanently
	:syntax manual	per-file basis
	:set syntax=ON	turn back on
6.5
	:hardcopy	print with colors
6.6
	syntax reference
7.1
	:e*dit
	:w*rite
	:hide		WTF?
	:n*ext
	:wn*ext		:w + :n
	:p*revious
	:wp*revious
	:first
	:last
	:set autowrite
	:args
7.3
	^^	edit alternate, like :e #
	`"	mark: last time here
	`.	mark: last change
7.4
	:set backup		ext=~
	:set backupext=.bak
	:set patchmode=.orig
7.5
	"r	register x for cut/copy/paste
	:w >> file	append to file
7.6
	vim -M or :set (no)modifiable		no mods
	vim -R or :set (no)write		read-only
7.7
	:file   newname
	:saveas newname
8.1
	:split		split windows
	:close		close windows
	:only		only  windows
8.2
	:split name	split and edit
	^W+		inc window size
	^W-		dec window size
	#^W_		set window size
	^W_		max window size
8.3
	:vsplit file	vertical split
8.4
	^W[hjkl]	Move to Window <, v, ^, >
	^W[tb]		Window Top/Bottom
8.5
	^W[HJKL]	Move Window to <, v, ^, >
8.6
	:qall		quit  all windows
	:wall		write all windows
	vi -o files	each in own window
8.7
	vimdiff one two
	:diffupdate	refresh
	zo/zc		fold open/close
	]c/[c		next/prev change
	dp		diff put (into other window)
	do		diff get (obtain)
8.8
	^W^^		split & edit alternate
8.9
	:tabedit file
	:tab split
9.3
	"*	current selection
	"+	real clipboard
	:set selectmode+=mouse
10.1
	qx	start recording into register x
	qX	start recording into register x appending
	q	stop  recording
	@x	execute macro
	@@	previous macro
10.2
	:[range]s/from/to/flags
	:%s///		all lines
	:s///g		global  change
	:s///c		confirm change
	:s///o		print   change
10.3
	:#s		one line
	:#,#		range. $ is last
	:?back?,/fore/	searches
	:'t,'b		marks
	:'<,'>		visual range
10.4
	:[range]g/pat/cmd	filter cmd
	:[range]v/pat/cmd	filter cmd not
10.5
	In Block Visual Mode
	Itext	inserts at left edge
	Atext	inserts at rite edge
	ctext	changes block
	Ctext	changes block to end line
	rx	relaces every char in block
	~	change case
	u	lower  case
	U	upper  case
10.6
	:r*ead  file
	:0r*ead file
10.7
	:set textwidth
10.8
	gumotion	lowercase
	gUmotion	uppercase
	g~motion	swap case
	guu, gUU, g~~	wholw line
10.9
	!motion		filter region
	:r !cmd		insert cmd output
	:w !cmd		pipe to cmd
	^L		redraw screen
11.1
	vi -r [file]	recover file or list possibiles
	:recover
12.5
	g^G		different status, also in Visual mode
12.6
	K		run man on word under cursor
	:man cmd	run man
12.8
	:grep string files	edits files containing string
	:cnext			next file
	:cprev			prev file
	:clist			list files
20.1
	:command \    /	use LEFT and RIGHT to move, BS to erase
	/search  +>--<+ use HOME or END, RET to execute
	?search  /    \ use UP and DOWN to move thru history
20.2
	:com			use TAB to show possibles
	option names can be tab-completed too
20.3
	filenames can be tab-completed too when expected
	^I	goes to next completion
	^N	goes to next completion
	^P	goes to prev completion
	^D	lists  all   completions
	^A	insert all   completions
	^L	longest      completion
20.4
	UP and DOWN scroll thru history
20.5
	q:	opens command line history window
21.1
	^Z	suspend
21.2
	:!cmd args	execute command
	:r !cmd args	read from command
	:w !cmd args	write to  command
	:[range]!cmd	filter thru command
	:shell		subshell
21.3
	:set viminfo=stuff	remember between sessions
	'0			where on last exit
	'1 - .9			older positions
	:wviminfo! ~/tmp/viminfo	write info	
	:rviminfo! ~/tmp/viminfo	read  info	
21.4
	:mksession vimbook.vim
        :source vimbook.vim
        vim -S vimbook.vim
        :set sessionoptions+=resize
21.5
	:mkview file or #	make a view
	:loadview #		load a view
	:source file		load a view
21.6
        :set modelines=#	# first/last lines
        :set nomodeline		no mode line
	modelines contain: vim:options: usually in comments
22.1
	:edit /dir
        " <enter> : open file or directory ~
        " o : open new window for file/directory ~
        " O : open file in previously visited window ~
        " p : preview the file ~
        " i : toggle size/date listing ~
        " s : select sort field    r : reverse sort ~
        " - : go up one level      c : cd to this dir ~
        " R : rename file          D : delete file ~
        " :help file-explorer for detailed help ~
22.2
	:cd /dir
	:lcd /dir	cd this buffer only
	:pwd
22.3
	gf			goto file under cursor
	:hide			hide this buf
	:hide edit file		...and edit new file
        :buffers or :ls		lists buffers
        :buffer help
        :buffer 2
        :sbuffer 2		split first
        :bnext          	go to next buffer
        :bprevious     		go to previous buffer
        :bfirst         	go to the first buffer
        :blast          	go to the last buffer
        :bdelete 3		delete a buffer
23.1
        :set fileformats=unix,dos,mac
        :set fileformat=unix	ask   the format
        :set fileformat=unix	force the format
23.2
	gf and :e 		work on URLs too
	ftp/http/rcp/scp	nfs would be nice
23.3
	vim -x			does encryption
	:set key=[key]		empty disables
	:X			ask for key
	vim -n			no swap file (for encryption)
23.4
	vim -b datafile		binary data
        :set display=uhex
	ga			show char
	#go			goto char #
23.5
	.Z, .gz, .bz2		vim edits these
24.1
	BS		del bwd
	DEL		del fwd
	^W		del bwd word
	^U		del bwd line
	Arrows		move in line
	^Arrows		move in line by words
	HOME, END	of line
	^HOME, ^END	of file
	PageUp/Dn	screenful
24.2
        :set showmatch
        :set matchtime=15
24.3
	^P			completes words
        CTRL-X CTRL-F           file names
        CTRL-X CTRL-L           whole lines
        CTRL-X CTRL-D           macro definitions (also in included files)
        CTRL-X CTRL-I           current and included files
        CTRL-X CTRL-K           words from a dictionary
        CTRL-X CTRL-T           words from a thesaurus
        CTRL-X CTRL-]           tags
        CTRL-X CTRL-V           Vim command line
        CTRL-X CTRL-O           Complete Omni
24.[456]
	i^A			repeat last insert
	^@			and exit insert
	^Y, ^E			text above/below cursor
	^Rr			insert register r
24.7
	:iab x wqyz		abbrebiate
	:unab x			unabbrebiate
	:abclear		remove all
24.8
	^V char			literal escape
	^Q char			use on Windows
	^V digits		insert numeric code
	^V [oxuU]digits		octal, hex, unicode 16/32 bit
24.9
	^K xy			digraph
	:digraphs
24.10
	^O cmd			execute one normal mode command
25.1
        :set textwidth=30
	gq motion		format operator
25.2
	:[range]center width	center lines
	:[range]right  width	RJ     lines
	:[range]left   indent	indent lines
25.3
	:set autoindent
        :set shiftwidth=4
        :set softtabstop=4







