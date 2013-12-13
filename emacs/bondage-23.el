;23-;;;;(if (vectorp help-map)
;23-;;;;    nil
;23-;;;;  (let* ((hm (make-vector 128 nil))
;23-;;;;	(n 127))
;23-;;;;    (while (natnump n)
;23-;;;;      (aset hm n
;23-;;;;	    (lookup-key help-map (char-to-string n)))
;23-;;;;      (setq n (1- n)))
;23-;;;;    (fset 'help-command (setq help-map hm))))
;23-;;;;
;23-(defun set-key (arg) "\
;23-Switch on prefix arg for {global,local}-{set,unset}-key:
;23-none => GSK; ^U => LSK; ^U - => GUK; ^U # => LUK."
;23-  (interactive "P")
;23-  (call-interactively
;23-   (if (listp arg)
;23-       (if arg 'local-set-key 'global-set-key)
;23-     (if (symbolp arg) 'global-unset-key 'local-unset-key))))
;23-
;23-(defvar tick-meta t "*Use \"`\" as a meta key")
;23-
;23-(defun tick () "\
;23-If we are a VT220, remove local definition for backtick.
;23-This allows the global definition as a meta key to be used."
;23-  (interactive)
;23-  (and tick-meta
;23-       (local-unset-key  "`")))
;23-
;23-;;;;(define-key global-map	"\C-@"	(or () 'set-mark-command))
;23-(define-key global-map	"\C-a"	(or 'scroll-up 'beginning-of-line)) ;^V
;23-;;;;(define-key global-map	"\C-b"	(or () 'backward-char))
;23-;;;;(define-key global-map	"\C-c"	(or () 'mode-specific-command-prefix))
;23-;;;;(define-key global-map	"\C-d"	(or () 'delete-char))
;23-;;;;(define-key global-map	"\C-e"	(or () 'end-of-line))
;23-;;;;(define-key global-map	"\C-f"	(or () 'forward-char))
;23-;;;;(define-key global-map	"\C-g"	(and 'never 'keyboard-quit))
;23-;;;;(define-key global-map	"\C-h"	(or () 'ehelp-command))
;23-;;;;(define-key global-map	"\C-i"	(or () 'indent-for-tab-command))
;23-;;;;(define-key global-map	"\C-j"	(or () 'newline-and-indent))
;23-;;;;(define-key global-map	"\C-k"	(or () 'kill-line))
;23-;;;;(define-key global-map	"\C-l"	(or () 'recenter)) ;???
;23-;;;;(define-key global-map	"\C-m"	(or () 'newline)) ;???
;23-;;;;(define-key global-map	"\C-n"	(or () 'next-line))
;23-;;;;(define-key global-map	"\C-o"	(or () 'open-line))
;23-;;;;(define-key global-map	"\C-p"	(or () 'previous-line))
;23-;;;;(define-key global-map	"\C-q"	(or () 'quoted-insert))	;???
;23-;;;;(define-key global-map	"\C-r"	(or () 'isearch-backward))
;23-(define-key global-map	"\C-s"	(or 'transpose-chars 'isearch-forward))	;^T
;23-(define-key global-map	"\C-t"	(or 'isearch-forward 'transpose-chars))	;^S
;23-;;;;(define-key global-map	"\C-u"	(or () 'universal-argument))
;23-(define-key global-map	"\C-v"	(or 'beginning-of-line 'scroll-up)) ;^A
;23-;;;;(define-key global-map	"\C-w"	(or () 'kill-region))
;23-;;;;(define-key global-map	"\C-x"	(or () 'Control-X-prefix))
;23-;;;;(define-key global-map	"\C-y"	(or () 'yank))
;23-(define-key global-map	"\C-z"	(or 'scroll-down
;23-				    'iconify-or-deiconify-frame)) ;^X^Z
;23-;;;;(define-key global-map	"\C-["	(or () 'ESC-prefix))
;23-;;;;(define-key global-map	"\C-\\"	(or () 'never))	;=> ^S
;23-(define-key global-map	"\C-]"	(or 'other-window 'abort-recursive-edit)) ;$^_
;23-;;;;(define-key global-map	"\C-^"	(or () 'never))	;=> ^Q
;23-;;;;(define-key global-map	"\C-_"	(or () 'undo))
;23-(define-key global-map	"`"	(or 'ESC-prefix 'self-insert-command))
;23-;;;;(define-key global-map	"\C-?"	(or () 'delete-backward-char))
;23-;;;;
;23-;;;;(define-key esc-map	"\C-@"	(or () 'mark-sexp))
;23-;;;;(define-key esc-map	"\C-a"	(or () 'beginning-of-defun))
;23-;;;;(define-key esc-map	"\C-b"	(or () 'backward-sexp))
;23-;;;;(define-key esc-map	"\C-c"	(or () 'exit-recursive-edit))
;23-;;;;(define-key esc-map	"\C-d"	(or () 'down-list))
;23-;;;;(define-key esc-map	"\C-e"	(or () 'end-of-defun))
;23-;;;;(define-key esc-map	"\C-f"	(or () 'forward-sexp))
;23-;;;;(define-key esc-map	"\C-g"	(and 'never nil))
;23-;;;;(define-key esc-map	"\C-h"	(or () 'mark-defun))
;23-(define-key esc-map	"\C-i"	(or 'lisp-complete-symbol 'complete-tag))
;23-;;;;(define-key esc-map	"\C-j"	(or () 'indent-new-comment-line)) ;???
;23-;;;;(define-key esc-map	"\C-k"	(or () 'kill-sexp))
;23-(define-key esc-map	"\C-l"	(or 'count-lines-region
;23-				    'reposition-window)) ; 19
;23-(define-key esc-map	[\C-return]
;23-(define-key esc-map	"\C-m"	(or 'scroll-other-window nil))
;23-)
;23-;;;;(define-key esc-map	"\C-n"	(or () 'forward-list))
;23-;;;;(define-key esc-map	"\C-o"	(or () 'split-line))
;23-;;;;(define-key esc-map	"\C-p"	(or () 'backward-list))
;23-(define-key esc-map	"\C-q"	(or 'indent-sexp nil)) ;from lisp mode
;23-(define-key esc-map	"\C-r"	(or 'isearch-backward-regexp nil)) ;???
;23-;;;;(define-key esc-map	"\C-s"	(or () 'isearch-forward-regexp)) ;???
;23-;;;;(define-key esc-map	"\C-t"	(or () 'transpose-sexps))
;23-;;;;(define-key esc-map	"\C-u"	(or () 'backward-up-list))
;23-(define-key esc-map	"\C-v"	(or 'up-list 'scroll-other-window)) ;$^M
;23-;;;;(define-key esc-map	"\C-w"	(or () 'append-next-kill))
;23-;;;;(define-key esc-map	"\C-x"	(or () 'eval-defun))
;23-(define-key esc-map	"\C-y"	(or 'eval-region nil))
;23-(define-key esc-map	"\C-z"	(or 'eval-current-buffer nil))
;23-;;;;(define-key esc-map	"\C-["	(or () 'eval-expression))
;23-;;;;(define-key esc-map	"\C-\\"	(or 'never 'indent-region)) ;$\
;23-;;;;(define-key esc-map	"\C-\\"	(or 'scroll-other-window 'indent-region)) ;$\
;23-(define-key esc-map	"\C-]"	(or 'scroll-other-window-down nil))
;23-;;;;(define-key esc-map	"\C-^"	(or () 'never))
;23-(define-key esc-map	"\C-_"	(or 'abort-recursive-edit nil))
;23-(define-key esc-map	" "	(or 'set-mark-command 'just-one-space))	;^XSPC
;23-(define-key esc-map	"!"	(or () 'shell-command))
;23-;;;;(define-key esc-map	"\""	(or 'mail-quote nil)) ;;mail mode
;23-(define-key esc-map	"#"	(or 'spell-buffer nil))
;23-(define-key esc-map	"$"	(or () 'spell-word))
;23-;;;;(define-key esc-map	"%"	(or () 'query-replace))
;23-(define-key esc-map	"&"	(or 'hack-local-variables-command nil))
;23-;;;;(define-key esc-map	"'"	(or () 'abbrev-prefix-mark))
;23-;;;;(define-key esc-map	"("	(or () 'insert-parentheses))
;23-;;;;(define-key esc-map	")"	(or () 'move-past-close-and-reindent))
;23-(define-key esc-map	"*"	(or 'set-key nil))
;23-;;;;(define-key esc-map	"+"	(or 'make-command-summary nil))
;23-(define-key esc-map	","	(or 'beginning-of-buffer 'tags-loop-continue))
;23-;;;;(define-key esc-map	"-"	(or () 'negative-argument))
;23-(define-key esc-map	"."	(or 'end-of-buffer 'find-tag))
;23-;;;;(define-key esc-map	"/"	(or () 'dabbrev-expand))
;23-(define-key esc-map	":"	(or 'print-buffer nil))
;23-(define-key global-map	[?\C-\;]
;23-(define-key esc-map	";"	(or () 'indent-for-comment))
;23-)
;23-(define-key esc-map	"<"	(or 'tags-loop-continue 'beginning-of-buffer))
;23-(define-key esc-map	"="	(or 'what-line 'count-lines-region)) ;$^L
;23-(define-key esc-map	">"	(or 'find-tag 'end-of-buffer))
;23-(define-key esc-map	"?"	(or 'print-region nil))
;23-;;;;
;23-;;;;(define-key esc-map	"@"	(or () 'mark-word))
;23-;;;;(define-key esc-map	"O"	(and 'SS3-map nil)) ;vt[12]00
;23-;;;;(define-key esc-map	"["	(and 'CSI-map 'backward-paragraph)) ;vt[12]00
;23-(define-key esc-map	"\\"	(or 'indent-region
;23-				    'delete-horizontal-space)) ;^H SPC
;23-(define-key esc-map	"]"	(or 'delete-indentation nil))
;23-;;;;(define-key esc-map	"^"	(or () 'delete-indentation))
;23-;;;;(define-key esc-map	"_"	(and 'tvi-map nil)) ;tvi950
;23-(define-key esc-map	"`"	(or 'self-insert-command nil))
;23-;;;;(define-key esc-map	"a"	(or () 'backward-sentence))
;23-;;;;(define-key esc-map	"b"	(or () 'backward-word))
;23-;;;;(define-key esc-map	"c"	(or () 'capitalize-word))
;23-;;;;(define-key esc-map	"d"	(or () 'kill-word))
;23-;;;;(define-key esc-map	"e"	(or () 'forward-sentence))
;23-;;;;(define-key esc-map	"f"	(or () 'forward-word))
;23-;;;;(define-key esc-map	"g"	(or () 'fill-region))
;23-;;;;(define-key esc-map	"h"	(or () 'mark-paragraph))
;23-;;;;(define-key esc-map	"i"	(or () 'tab-to-tab-stop))
;23-;;;;(define-key esc-map	"j"	(or () 'indent-new-comment-line))
;23-;;;;(define-key esc-map	"k"	(or () 'kill-sentence))
;23-;;;;(define-key esc-map	"l"	(or () 'downcase-word))
;23-;;;;(define-key esc-map	"m"	(or () 'back-to-indentation))
;23-(define-key esc-map	"n"	(or 'rename-buffer nil))
;23-(define-key esc-map	"o"	(or 'occur nil))
;23-(define-key esc-map	"p"	(or 'pwd nil))
;23-;;;;(define-key shared-lisp-mode-map "\M-q"
;23-(define-key esc-map	"q"	(or 'query-replace 'fill-paragraph)) ;^X^H
;23-;;;;)
;23-(define-key esc-map	"r"	(or 'query-replace-regexp
;23-				    'move-to-window-line)) ; ???
;23-(define-key esc-map	"s"	(or 'set-variable nil))
;23-;;;;(define-key esc-map	"t"	(or () 'transpose-words))
;23-;;;;(define-key esc-map	"u"	(or () 'upcase-word))
;23-;;;;(define-key esc-map	"v"	(or 'view-buffer 'scroll-down))	;^Z
;23-;;;;(define-key esc-map	"w"	(or () 'copy-region-as-kill))
;23-;;;;(define-key esc-map	"x"	(or () 'execute-extended-command))
;23-;;;;(define-key esc-map	"y"	(or () 'yank-pop))
;23-;;;;(define-key esc-map	"z"	(or () 'zap-to-char))
;23-(define-key esc-map	"{"	(or () 'backward-paragraph))
;23-(define-key esc-map	"|"	(or () 'shell-command-on-region))
;23-(define-key esc-map	"}"	(or () 'forward-paragraph))
;23-(define-key esc-map	"~"	(or () 'not-modified))
;23-(define-key esc-map	"\C-?"	(or () 'backward-kill-word))
;23-;;;;
;23-;;;;(define-key ctl-x-map	"\C-@"	(and 'sun-mouse-handler nil)) ;emacstool
;23-;;;;(define-key ctl-x-map	"\C-a"	(or 'append-to-file 'add-mode-abbrev)) ;^H+
;23-(define-key ctl-x-map	"\C-b"	(or 'buffer-menu 'list-buffers)) ;^Xb!
;23-;;;;(define-key ctl-x-map	"\C-c"	(or () 'save-buffers-kill-emacs))
;23-;;;;(define-key ctl-x-map	"\C-d"	(or () 'list-directory))
;23-;;;;(define-key ctl-x-map	"\C-e"	(or () 'eval-last-sexp))
;23-;;;;(define-key ctl-x-map	"\C-f"	(or () 'find-file))
;23-;;;;(define-key ctl-x-map	"\C-g"	(and 'never nil))
;23-(define-key ctl-x-map	"\C-h"	(or 'fill-paragraph
;23-				    'inverse-add-mode-abbrev)) ;^H-
;23-(define-key ctl-x-map	"\C-i"	(or 'insert-file 'indent-rigidly)) ;none
;23-(define-key ctl-x-map	"\C-j"	(or 'set-variable nil))
;23-(define-key ctl-x-map	"\C-k"	(or 'bury-buffer nil))
;23-(define-key ctl-x-map	"\C-l"	(or 'count-lines-page 'downcase-region)) ;^Xl
;23-;;;;(define-key ctl-x-map	"\C-m"	(or 'rmail-file nil))
;23-;;;;(define-key ctl-x-map	"\C-n"	(or 'next-error 'set-goal-column))
;23-;;;;(define-key ctl-x-map	"\C-o"	(or () 'delete-blank-lines))
;23-;;;;(define-key ctl-x-map	"\C-p"	(or () 'mark-page))
;23-;;;;(define-key ctl-x-map	"\C-q"	(or () 'toggle-read-only))
;23-(define-key ctl-x-map	"\C-r"	(or 'ro-mode
;23-				    'find-file-read-only)) ;none
;23-;;;;(define-key ctl-x-map	"\C-s"	(or () 'save-buffer))
;23-;;;;(define-key ctl-x-map	"\C-t"	(or () 'transpose-lines))
;23-(define-key ctl-x-map	"\C-u"	(or 'advertised-undo 'upcase-region)) ; ^Xu
;23-;;;;(define-key ctl-x-map	"\C-v"	(or () 'find-alternate-file))
;23-;;;;(define-key ctl-x-map	"\C-w"	(or () 'write-file))
;23-;;;;(define-key ctl-x-map	"\C-x"	(or () 'exchange-point-and-mark))
;23-;;;;(define-key ctl-x-map	"\C-y"	(or 'yowza nil))
;23-(define-key ctl-x-map	"\C-z"
;23-  (or () (if window-system 'iconify-or-deiconify-frame 'suspend-emacs)))
;23-(define-key ctl-x-map	"\C-["	(or () 'repeat-complex-command))
;23-;;;;(define-key ctl-x-map	"\C-\\"	(or 'never nil))
;23-;;;;(define-key ctl-x-map	"\C-]"	(or 'blink-paren 'forward-page)) ;???
;23-;;;;(define-key ctl-x-map	"\C-^"	(or 'never nil))
;23-(define-key ctl-x-map	"\C-_"	(or 'backward-kill-sexp nil)) ;???
;23-(define-key ctl-x-map	" "	(or 'just-one-space nil))
;23-(define-key ctl-x-map	"!"	(or 'shell nil))
;23-;;;;(define-key ctl-x-map	"\""	(or 'mail-uucp nil)) ;;mail mode
;23-(define-key ctl-x-map	"#"	(or 'server-edit nil)) ;server
;23-;;;;(define-key ctl-x-map	"$"	(or () 'set-selective-display))
;23-;;;;(define-key ctl-x-map	"%"	(or () nil))
;23-;;;;(define-key ctl-x-map	"&"	(or () nil))
;23-;;;;(define-key ctl-x-map	"'"	(or () 'expand-abbrev))
;23-;;;;(define-key ctl-x-map	"("	(or () 'start-kbd-macro))
;23-;;;;(define-key ctl-x-map	")"	(or () 'end-kbd-macro))
;23-;;;;(define-key ctl-x-map	"*"	(or () nil)) ;used by sun-mouse
;23-;;;;(define-key ctl-x-map	"+"	(or () 'add-global-abbrev))
;23-;;;;(define-key ctl-x-map	","	(or () nil))
;23-;;;;(define-key ctl-x-map	"-"	(or () 'inverse-add-global-abbrev))
;23-;;;;(define-key ctl-x-map	"."	(or () 'set-fill-prefix)) ;???
;23-;;;;(define-key ctl-x-map	"/"	(or () 'point-to-register))
;23-;;;;
;23-(define-key ctl-x-map	"0"	(or () 'delete-window))
;23-(define-key ctl-x-map	"1"	(or () 'delete-other-windows))
;23-(define-key ctl-x-map	"2"	(or () 'split-window-vertically))
;23-(define-key ctl-x-map	"3"	(or () 'split-window-horizontally))
;23-(define-key ctl-x-map	"4"	(or 'shell 'ctl-x-4-prefix)) ;forget prefix!
;23-;;;;(define-key ctl-x-map	"5"	(or () 'OTHER-FRAME-STUFF)) ;???
;23-(define-key ctl-x-map	"6"	(or 'enlarge-window 'TWO-COLUMN-STUFF))
;23-(define-key ctl-x-map	"7"	(or 'compare-windows nil))
;23-(define-key ctl-x-map	"8"	(or 'perl-mode nil))
;23-(define-key ctl-x-map	"9"	(or 'perldb nil))
;23-(define-key ctl-x-map	":"	(or 'lpr-buffer nil))
;23-;;;;(define-key ctl-x-map	";"	(or () 'set-comment-column))
;23-;;;;(define-key ctl-x-map	"<"	(or () 'scroll-left))
;23-;;;;(define-key ctl-x-map	"="	(or () 'what-cursor-position))
;23-;;;;(define-key ctl-x-map	">"	(or () 'scroll-right))
;23-(define-key ctl-x-map	"?"	(or 'lpr-region nil))
;23-;;;;(define-key ctl-x-map	"@"	(or () nil))
;23-;;;;(define-key ctl-x-map	"["	(or () 'backward-page))
;23-(define-key ctl-x-map	"\\"	(or 'electric-command-history nil))
;23-;;;;(define-key ctl-x-map	"]"	(or () 'forward-page))
;23-;;;;(define-key ctl-x-map	"^"	(or () 'enlarge-window))
;23-;;;;(define-key ctl-x-map	"_"	(or () nil))
;23-;;;;(define-key ctl-x-map	"`"	(or () 'next-error))
;23-;;;;(define-key ctl-x-map	"a"	(or () 'append-to-buffer))
;23-;;;;(define-key ctl-x-map	"b"	(or () 'switch-to-buffer))
;23-(define-key ctl-x-map	"c"	(or 'cd nil)) ;???
;23-(define-key ctl-x-map	"d"	(or 'zap-lines 'dired)) ;use ^X^F
;23-;;;;(define-key ctl-x-map	"e"	(or () 'call-last-kbd-macro))
;23-;;;;(define-key ctl-x-map	"f"	(or () 'set-fill-column)) ;none
;23-;;;;(define-key ctl-x-map	"g"	(or () 'insert-register))
;23-;;;;(define-key ctl-x-map	"h"	(or () 'mark-whole-buffer))
;23-(define-key ctl-x-map	"i"	(or 'insert-buffer 'insert-file)) ; ^X^I
;23-;;;;(define-key ctl-x-map	"j"	(or () 'register-to-point))
;23-;;;;(define-key ctl-x-map	"k"	(or () 'kill-buffer))
;23-(define-key ctl-x-map	"l"	(or 'downcase-region 'count-lines-page)) ;^X^L
;23-;;;;(define-key ctl-x-map	"m"	(or () 'mail))
;23-;;;;(define-key ctl-x-map	"n"	(or () 'narrow-to-region))
;23-;;;;(define-key ctl-x-map	"o"	(or () 'other-window))
;23-;;;;(define-key ctl-x-map	"p"	(or () 'narrow-to-page))
;23-;;;;(define-key ctl-x-map	"q"	(or () 'kbd-macro-query))
;23-;;;;(define-key ctl-x-map	"r"	(or () 'copy-rectangle-to-register))
;23-;;;;(define-key ctl-x-map	"s"	(or () 'save-some-buffers))
;23-(define-key ctl-x-map	"t"	(or 'mark-line nil))
;23-(define-key ctl-x-map	"u"	(or 'capitalize-region 'advertised-undo)) ;^X^U
;23-;;;;(define-key ctl-x-map	"v"	(or 'view-file nil))
;23-;;;;(define-key ctl-x-map	"w"	(or () 'widen))
;23-;;;;(define-key ctl-x-map	"x"	(or () 'copy-to-register))
;23-;;;;(define-key ctl-x-map	"y"	(or 'prev-complex-command nil))
;23-;;;;(define-key ctl-x-map	"z"	(or 'rerun-prev-command nil)) ;???
;23-;;;;(define-key ctl-x-map	"{"	(or () 'shrink-window-horizontally))
;23-(define-key ctl-x-map	"|"	(or 'recover-file nil))
;23-;;;;(define-key ctl-x-map	"}"	(or () 'enlarge-window-horizontally))
;23-(define-key ctl-x-map	"~"	(or 'revert-buffer nil))
;23-;;;;(define-key ctl-x-map	"\C-?"	(or () 'backward-kill-sentence))
;23-;;;;
;23-(define-key help-map	"\C-@"	(or 'blackbox nil))
;23-(define-key help-map	"\C-a"	(or 'command-apropos nil))
;23-(define-key help-map	"\C-b"	(or 'describe-bindings nil))
;23-(define-key help-map	"\C-c"	(or 'describe-key-briefly
;23-				    'describe-copying)) ;none
;23-(define-key help-map	"\C-d"	(or 'dup-line 'describe-distribution)) ;none
;23-(define-key help-map	"\C-e"	(or 'call-last-kbd-macro nil))
;23-(define-key help-map	"\C-f"	(or 'describe-function
;23-				    'Info-goto-emacs-command-node)) ; ^Hd
;23-(define-key help-map	"\C-g"	(and 'never nil))
;23-(define-key help-map	"\C-h"	(or () 'help-for-help))
;23-(define-key help-map	"\C-i"	(or 'info nil))
;23-(define-key help-map	"\C-j"	(or 'goto-line nil))
;23-(define-key help-map	"\C-k"	(or 'describe-key
;23-				    'Info-goto-emacs-key-command-node)) ; ^He
;23-(define-key help-map	"\C-l"	(or 'load-library nil))
;23-(define-key help-map	"\C-m"	(or 'describe-mode nil))
;23-(define-key help-map	"\C-n"	(or 'forward-to-indentation 'view-emacs-news))
;23-(define-key help-map	"\C-o"	(or 'display-buffer nil))
;23-(define-key help-map	"\C-p"	(or 'backward-to-indentation nil))
;23-(define-key help-map	"\C-q"	(or 'bugger nil))
;23-(define-key help-map	"\C-r"	(or 'byte-recompile-directory nil))
;23-(define-key help-map	"\C-s"	(or 'describe-syntax nil))
;23-(define-key help-map	"\C-t"	(or 'tick nil))
;23-(define-key help-map	"\C-u"	(or 'describe-c-function nil))
;23-(define-key help-map	"\C-v"	(or 'describe-variable nil))
;23-(define-key help-map	"\C-w"	(or 'where-is 'describe-no-warranty)) ;none
;23-(define-key help-map	"\C-x"	(or 'ding nil))
;23-(define-key help-map	"\C-y"	(or 'random-yow nil))
;23-(define-key help-map	"\C-z"	(or () nil))
;23-(define-key help-map	"\C-["	(or 'start-kbd-macro nil))
;23-(define-key help-map	"\C-\\"	(or 'never nil))
;23-(define-key help-map	"\C-]"	(or 'end-kbd-macro nil))
;23-(define-key help-map	"\C-^"	(or 'never nil))
;23-(define-key help-map	"\C-_"	(or () nil))
;23-;;;;
;23-(define-key help-map	" "	(or 'delete-horizontal-space nil))
;23-;;;;(define-key help-map	"!"	(or 'gdb nil))
;23-;;;;(define-key help-map	"\""	(or () nil))
;23-(define-key help-map	"#"	(or 'server-start nil))
;23-;;;;(define-key help-map	"$"	(or () nil))
;23-;;;;(define-key help-map	"%"	(or () nil))
;23-;;;;(define-key help-map	"&"	(or () nil))
;23-;;;;(define-key help-map	"'"	(or 'unexpand-abbrev nil))
;23-;;;;(define-key help-map	"("	(or () nil))
;23-;;;;(define-key help-map	")"	(or () nil))
;23-(define-key help-map	"*"	(or 'set-variable nil))
;23-;;;;(define-key help-map	"+"	(or 'add-mode-abbrev nil))
;23-;;;;(define-key help-map	","	(or () nil))
;23-;;;;(define-key help-map	"-"	(or 'inverse-add-mode-abbrev nil))
;23-(define-key help-map	"."	(or 'find-tag-other-window nil))
;23-(define-key help-map	"/"	(or 'expand-region-abbrevs nil))
;23-;;;;(define-key help-map	"0"	(or () nil))
;23-;;;;(define-key help-map	"1"	(or () nil))
;23-;;;;(define-key help-map	"2"	(or () nil))
;23-;;;;(define-key help-map	"3"	(or () nil))
;23-;;;;(define-key help-map	"4"	(or () nil))
;23-;;;;(define-key help-map	"5"	(or () nil))
;23-;;;;(define-key help-map	"6"	(or () nil))
;23-;;;;(define-key help-map	"7"	(or () nil))
;23-;;;;(define-key help-map	"8"	(or () nil))
;23-;;;;(define-key help-map	"9"	(or () nil))
;23-(define-key help-map	":"	(or 'sort-colon nil))
;23-(define-key global-map	[?\M-\C-\;]
;23-(define-key help-map	";"	(or 'kill-comment nil))
;23-)
;23-;;;;(define-key help-map	"<"	(or () nil))
;23-(define-key help-map	"="	(or 'what-page nil))
;23-;;;;(define-key help-map	">"	(or () nil))
;23-;;;;(define-key help-map	"?"	(or () 'help-for-help))
;23-;;;;
;23-;;;;(define-key help-map	"@"	(or () nil))
;23-;;;;(define-key help-map	"["	(or () nil))
;23-;;;;(define-key help-map	"\\"	(or () nil))
;23-;;;;(define-key help-map	"]"	(or () nil))
;23-;;;;(define-key help-map	"^"	(or () nil))
;23-;;;;(define-key help-map	"_"	(or () nil))
;23-(define-key help-map	"`"	(or 'bell nil))
;23-(define-key help-map	"a"	(or 'apropos 'command-apropos))	;^H^A
;23-(define-key help-map	"b"	(or 'switch-to-buffer-other-window
;23-				    'describe-bindings)) ;^H^B
;23-(define-key help-map	"c"	(or 'compile 'describe-key-briefly)) ;^H^C
;23-(define-key help-map	"d"	(or 'Info-goto-emacs-command-node
;23-				    'describe-function)) ;use ^Hf
;23-(define-key help-map	"e"	(or 'Info-goto-emacs-key-command-node nil))
;23-(define-key help-map	"f"	(or 'find-file-other-window
;23-				    'describe-function)) ;^H^F
;23-(define-key help-map	"g"	(or 'grep nil))
;23-;;;;(define-key help-map	"h"	(or 'rmail-header-clean nil)) ;;rmail mode
;23-;;;;(define-key help-map	"i"	(or () 'info))
;23-(define-key help-map	"j"	(or 'goto-char nil))
;23-;;;;(define-key help-map	"k"	(or 'kill-rectangle 'describe-key)) ;^H^K
;23-(define-key help-map	"l"	(or 'list-tags 'view-lossage)) ;none
;23-(define-key help-map	"m"	(or 'man
;23-				    'describe-mode)) ;^H^M
;23-(define-key help-map	"n"	(or 'next-file 'view-emacs-news)) ;none
;23-(define-key help-map	"o"	(or 'occur-sorted nil))
;23-;;;;(define-key help-map	"p"	(or () nil))
;23-;;;;(define-key help-map	"q"	(or 'tags-query-replace nil))
;23-;;;;(define-key help-map	"r"	(or 'rmail-summary-sort nil)) ;;rmail summary
;23-(define-key help-map	"s"	(or 'tags-search 'describe-syntax)) ;^H^S
;23-(define-key help-map	"t"	(or 'tags-apropos 'help-with-tutorial))	;none
;23-(define-key help-map	"u"	(or 'buffer-enable-undo nil))
;23-(define-key help-map	"v"	(or 'visit-tags-table 'describe-variable));^H^V
;23-;;;;(define-key help-map	"w"	(or () 'where-is))
;23-;;;;(define-key help-map	"x"	(or () nil))
;23-;;;;(define-key help-map	"y"	(or 'yank-rectangle nil))
;23-;;;;(define-key help-map	"z"	(or () nil))
;23-;;;;(define-key help-map	"{"	(or () nil))
;23-;;;;(define-key help-map	"|"	(or () nil))
;23-;;;;(define-key help-map	"}"	(or () nil))
;23-;;;;(define-key help-map	"~"	(or () nil))
;23-;;;;(define-key help-map	"\C-?"	(or 'backward-delete-untabify nil))
