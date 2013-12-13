;;;;(if (vectorp help-map)
;;;;    nil
;;;;  (let* ((hm (make-vector 128 nil))
;;;;	(n 127))
;;;;    (while (natnump n)
;;;;      (aset hm n
;;;;	    (lookup-key help-map (char-to-string n)))
;;;;      (setq n (1- n)))
;;;;    (fset 'help-command (setq help-map hm))))
;;;;
(defun set-key (arg) "\
Switch on prefix arg for {global,local}-{set,unset}-key:
none => GSK; ^U => LSK; ^U - => GUK; ^U # => LUK."
  (interactive "P")
  (call-interactively
   (if (listp arg)
       (if arg 'local-set-key 'global-set-key)
     (if (symbolp arg) 'global-unset-key 'local-unset-key))))

(defvar tick-meta t "*Use \"`\" as a meta key")

(defun tick () "\
If we are a VT220, remove local definition for backtick.
This allows the global definition as a meta key to be used."
  (interactive)
  (and tick-meta
       (local-unset-key  "`")))

;;;;(define-key global-map	"\C-@"	(or () 'set-mark-command))
(define-key global-map	"\C-a"	(or 'scroll-up 'beginning-of-line)) ;^V
;;;;(define-key global-map	"\C-b"	(or () 'backward-char))
;;;;(define-key global-map	"\C-c"	(or () 'mode-specific-command-prefix))
;;;;(define-key global-map	"\C-d"	(or () 'delete-char))
;;;;(define-key global-map	"\C-e"	(or () 'end-of-line))
;;;;(define-key global-map	"\C-f"	(or () 'forward-char))
;;;;(define-key global-map	"\C-g"	(and 'never 'keyboard-quit))
;;;;(define-key global-map	"\C-h"	(or () 'ehelp-command))
;;;;(define-key global-map	"\C-i"	(or () 'indent-for-tab-command))
;;;;(define-key global-map	"\C-j"	(or () 'newline-and-indent))
;;;;(define-key global-map	"\C-k"	(or () 'kill-line))
;;;;(define-key global-map	"\C-l"	(or () 'recenter)) ;???
;;;;(define-key global-map	"\C-m"	(or () 'newline)) ;???
;;;;(define-key global-map	"\C-n"	(or () 'next-line))
;;;;(define-key global-map	"\C-o"	(or () 'open-line))
;;;;(define-key global-map	"\C-p"	(or () 'previous-line))
;;;;(define-key global-map	"\C-q"	(or () 'quoted-insert))	;???
;;;;(define-key global-map	"\C-r"	(or () 'isearch-backward))
(define-key global-map	"\C-s"	(or 'transpose-chars 'isearch-forward))	;^T
(define-key global-map	"\C-t"	(or 'isearch-forward 'transpose-chars))	;^S
;;;;(define-key global-map	"\C-u"	(or () 'universal-argument))
(define-key global-map	"\C-v"	(or 'beginning-of-line 'scroll-up)) ;^A
;;;;(define-key global-map	"\C-w"	(or () 'kill-region))
;;;;(define-key global-map	"\C-x"	(or () 'Control-X-prefix))
;;;;(define-key global-map	"\C-y"	(or () 'yank))
(define-key global-map	"\C-z"	(or 'scroll-down
				    'iconify-or-deiconify-frame)) ;^X^Z
;;;;(define-key global-map	"\C-["	(or () 'ESC-prefix))
;;;;(define-key global-map	"\C-\\"	(or () 'never))	;=> ^S
(define-key global-map	"\C-]"	(or 'other-window 'abort-recursive-edit)) ;$^_
;;;;(define-key global-map	"\C-^"	(or () 'never))	;=> ^Q
;;;;(define-key global-map	"\C-_"	(or () 'undo))
(define-key global-map	"`"	(or 'ESC-prefix 'self-insert-command))
;;;;(define-key global-map	"\C-?"	(or () 'delete-backward-char))
;;;;
;;;;(define-key esc-map	"\C-@"	(or () 'mark-sexp))
;;;;(define-key esc-map	"\C-a"	(or () 'beginning-of-defun))
;;;;(define-key esc-map	"\C-b"	(or () 'backward-sexp))
;;;;(define-key esc-map	"\C-c"	(or () 'exit-recursive-edit))
;;;;(define-key esc-map	"\C-d"	(or () 'down-list))
;;;;(define-key esc-map	"\C-e"	(or () 'end-of-defun))
;;;;(define-key esc-map	"\C-f"	(or () 'forward-sexp))
;;;;(define-key esc-map	"\C-g"	(and 'never nil))
;;;;(define-key esc-map	"\C-h"	(or () 'mark-defun))
(define-key esc-map	"\C-i"	(or 'lisp-complete-symbol 'complete-tag))
;;;;(define-key esc-map	"\C-j"	(or () 'indent-new-comment-line)) ;???
;;;;(define-key esc-map	"\C-k"	(or () 'kill-sexp))
(define-key esc-map	"\C-l"	(or 'count-lines-region
				    'reposition-window)) ; 19
(define-key esc-map	[\C-return]
(define-key esc-map	"\C-m"	(or 'scroll-other-window nil))
)
;;;;(define-key esc-map	"\C-n"	(or () 'forward-list))
;;;;(define-key esc-map	"\C-o"	(or () 'split-line))
;;;;(define-key esc-map	"\C-p"	(or () 'backward-list))
(define-key esc-map	"\C-q"	(or 'indent-sexp nil)) ;from lisp mode
(define-key esc-map	"\C-r"	(or 'isearch-backward-regexp nil)) ;???
;;;;(define-key esc-map	"\C-s"	(or () 'isearch-forward-regexp)) ;???
;;;;(define-key esc-map	"\C-t"	(or () 'transpose-sexps))
;;;;(define-key esc-map	"\C-u"	(or () 'backward-up-list))
(define-key esc-map	"\C-v"	(or 'up-list 'scroll-other-window)) ;$^M
;;;;(define-key esc-map	"\C-w"	(or () 'append-next-kill))
;;;;(define-key esc-map	"\C-x"	(or () 'eval-defun))
(define-key esc-map	"\C-y"	(or 'eval-region nil))
(define-key esc-map	"\C-z"	(or 'eval-current-buffer nil))
;;;;(define-key esc-map	"\C-["	(or () 'eval-expression))
;;;;(define-key esc-map	"\C-\\"	(or 'never 'indent-region)) ;$\
;;;;(define-key esc-map	"\C-\\"	(or 'scroll-other-window 'indent-region)) ;$\
(define-key esc-map	"\C-]"	(or 'scroll-other-window-down nil))
;;;;(define-key esc-map	"\C-^"	(or () 'never))
(define-key esc-map	"\C-_"	(or 'abort-recursive-edit nil))
(define-key esc-map	" "	(or 'set-mark-command 'just-one-space))	;^XSPC
(define-key esc-map	"!"	(or () 'shell-command))
;;;;(define-key esc-map	"\""	(or 'mail-quote nil)) ;;mail mode
(define-key esc-map	"#"	(or 'spell-buffer nil))
(define-key esc-map	"$"	(or () 'spell-word))
;;;;(define-key esc-map	"%"	(or () 'query-replace))
(define-key esc-map	"&"	(or 'hack-local-variables-command nil))
;;;;(define-key esc-map	"'"	(or () 'abbrev-prefix-mark))
;;;;(define-key esc-map	"("	(or () 'insert-parentheses))
;;;;(define-key esc-map	")"	(or () 'move-past-close-and-reindent))
(define-key esc-map	"*"	(or 'set-key nil))
;;;;(define-key esc-map	"+"	(or 'make-command-summary nil))
(define-key esc-map	","	(or 'beginning-of-buffer 'tags-loop-continue))
;;;;(define-key esc-map	"-"	(or () 'negative-argument))
(define-key esc-map	"."	(or 'end-of-buffer 'find-tag))
;;;;(define-key esc-map	"/"	(or () 'dabbrev-expand))
(define-key esc-map	":"	(or 'print-buffer nil))
(define-key global-map	[?\C-\;]
(define-key esc-map	";"	(or () 'indent-for-comment))
)
(define-key esc-map	"<"	(or 'tags-loop-continue 'beginning-of-buffer))
(define-key esc-map	"="	(or 'what-line 'count-lines-region)) ;$^L
(define-key esc-map	">"	(or 'find-tag 'end-of-buffer))
(define-key esc-map	"?"	(or 'print-region nil))
;;;;
;;;;(define-key esc-map	"@"	(or () 'mark-word))
;;;;(define-key esc-map	"O"	(and 'SS3-map nil)) ;vt[12]00
;;;;(define-key esc-map	"["	(and 'CSI-map 'backward-paragraph)) ;vt[12]00
(define-key esc-map	"\\"	(or 'indent-region
				    'delete-horizontal-space)) ;^H SPC
(define-key esc-map	"]"	(or 'delete-indentation nil))
;;;;(define-key esc-map	"^"	(or () 'delete-indentation))
;;;;(define-key esc-map	"_"	(and 'tvi-map nil)) ;tvi950
(define-key esc-map	"`"	(or 'self-insert-command nil))
;;;;(define-key esc-map	"a"	(or () 'backward-sentence))
;;;;(define-key esc-map	"b"	(or () 'backward-word))
(define-key esc-map	"c"	(or 'upcase-word 'capitalize-word)) ;$u
;;;;(define-key esc-map	"d"	(or () 'kill-word))
;;;;(define-key esc-map	"e"	(or () 'forward-sentence))
;;;;(define-key esc-map	"f"	(or () 'forward-word))
;;;;(define-key esc-map	"g"	(or () 'fill-region))
;;;;(define-key esc-map	"h"	(or () 'mark-paragraph))
;;;;(define-key esc-map	"i"	(or () 'tab-to-tab-stop))
;;;;(define-key esc-map	"j"	(or () 'indent-new-comment-line))
;;;;(define-key esc-map	"k"	(or () 'kill-sentence))
;;;;(define-key esc-map	"l"	(or () 'downcase-word))
;;;;(define-key esc-map	"m"	(or () 'back-to-indentation))
(define-key esc-map	"n"	(or 'rename-buffer nil))
(define-key esc-map	"o"	(or 'occur nil))
(define-key esc-map	"p"	(or 'pwd nil))
;;;;(define-key shared-lisp-mode-map "\M-q"
(define-key esc-map	"q"	(or 'query-replace 'fill-paragraph)) ;^X^H
;;;;)
(define-key esc-map	"r"	(or 'query-replace-regexp
				    'move-to-window-line)) ; ???
(define-key esc-map	"s"	(or 'set-variable nil))
;;;;(define-key esc-map	"t"	(or () 'transpose-words))
(define-key esc-map	"u"	(or 'capitalize-word 'upcase-word)) ;$c
;;;;(define-key esc-map	"v"	(or 'view-buffer 'scroll-down))	;^Z
;;;;(define-key esc-map	"w"	(or () 'copy-region-as-kill))
;;;;(define-key esc-map	"x"	(or () 'execute-extended-command))
;;;;(define-key esc-map	"y"	(or () 'yank-pop))
;;;;(define-key esc-map	"z"	(or () 'zap-to-char))
(define-key esc-map	"{"	(or () 'backward-paragraph))
(define-key esc-map	"|"	(or () 'shell-command-on-region))
(define-key esc-map	"}"	(or () 'forward-paragraph))
(define-key esc-map	"~"	(or () 'not-modified))
(define-key esc-map	"\C-?"	(or () 'backward-kill-word))
;;;;
;;;;(define-key ctl-x-map	"\C-@"	(and 'sun-mouse-handler nil)) ;emacstool
;;;;(define-key ctl-x-map	"\C-a"	(or 'append-to-file 'add-mode-abbrev)) ;^H+
(define-key ctl-x-map	"\C-b"	(or 'buffer-menu 'list-buffers)) ;^Xb!
;;;;(define-key ctl-x-map	"\C-c"	(or () 'save-buffers-kill-emacs))
;;;;(define-key ctl-x-map	"\C-d"	(or () 'list-directory))
;;;;(define-key ctl-x-map	"\C-e"	(or () 'eval-last-sexp))
;;;;(define-key ctl-x-map	"\C-f"	(or () 'find-file))
;;;;(define-key ctl-x-map	"\C-g"	(and 'never nil))
(define-key ctl-x-map	"\C-h"	(or 'fill-paragraph
				    'inverse-add-mode-abbrev)) ;^H-
(define-key ctl-x-map	"\C-i"	(or 'insert-file 'indent-rigidly)) ;none
(define-key ctl-x-map	"\C-j"	(or 'set-variable nil))
(define-key ctl-x-map	"\C-k"	(or 'bury-buffer nil))
(define-key ctl-x-map	"\C-l"	(or 'count-lines-page 'downcase-region)) ;^Xl
;;;;(define-key ctl-x-map	"\C-m"	(or 'rmail-file nil))
;;;;(define-key ctl-x-map	"\C-n"	(or 'next-error 'set-goal-column))
;;;;(define-key ctl-x-map	"\C-o"	(or () 'delete-blank-lines))
;;;;(define-key ctl-x-map	"\C-p"	(or () 'mark-page))
;;;;(define-key ctl-x-map	"\C-q"	(or () 'toggle-read-only))
(define-key ctl-x-map	"\C-r"	(or 'ro-mode
				    'find-file-read-only)) ;none
;;;;(define-key ctl-x-map	"\C-s"	(or () 'save-buffer))
;;;;(define-key ctl-x-map	"\C-t"	(or () 'transpose-lines))
(define-key ctl-x-map	"\C-u"	(or 'advertised-undo 'upcase-region)) ; ^Xu
;;;;(define-key ctl-x-map	"\C-v"	(or () 'find-alternate-file))
;;;;(define-key ctl-x-map	"\C-w"	(or () 'write-file))
;;;;(define-key ctl-x-map	"\C-x"	(or () 'exchange-point-and-mark))
;;;;(define-key ctl-x-map	"\C-y"	(or 'yowza nil))
(define-key ctl-x-map	"\C-z"
  (or () (if window-system 'iconify-or-deiconify-frame 'suspend-emacs)))
(define-key ctl-x-map	"\C-["	(or () 'repeat-complex-command))
;;;;(define-key ctl-x-map	"\C-\\"	(or 'never nil))
;;;;(define-key ctl-x-map	"\C-]"	(or 'blink-paren 'forward-page)) ;???
;;;;(define-key ctl-x-map	"\C-^"	(or 'never nil))
(define-key ctl-x-map	"\C-_"	(or 'backward-kill-sexp nil)) ;???
(define-key ctl-x-map	" "	(or 'just-one-space nil))
(define-key ctl-x-map	"!"	(or 'shell nil))
;;;;(define-key ctl-x-map	"\""	(or 'mail-uucp nil)) ;;mail mode
(define-key ctl-x-map	"#"	(or 'server-edit nil)) ;server
;;;;(define-key ctl-x-map	"$"	(or () 'set-selective-display))
;;;;(define-key ctl-x-map	"%"	(or () nil))
;;;;(define-key ctl-x-map	"&"	(or () nil))
;;;;(define-key ctl-x-map	"'"	(or () 'expand-abbrev))
;;;;(define-key ctl-x-map	"("	(or () 'start-kbd-macro))
;;;;(define-key ctl-x-map	")"	(or () 'end-kbd-macro))
;;;;(define-key ctl-x-map	"*"	(or () nil)) ;used by sun-mouse
;;;;(define-key ctl-x-map	"+"	(or () 'add-global-abbrev))
;;;;(define-key ctl-x-map	","	(or () nil))
;;;;(define-key ctl-x-map	"-"	(or () 'inverse-add-global-abbrev))
;;;;(define-key ctl-x-map	"."	(or () 'set-fill-prefix)) ;???
;;;;(define-key ctl-x-map	"/"	(or () 'point-to-register))
;;;;
(define-key ctl-x-map	"0"	(or () 'delete-window))
(define-key ctl-x-map	"1"	(or () 'delete-other-windows))
(define-key ctl-x-map	"2"	(or () 'split-window-vertically))
(define-key ctl-x-map	"3"	(or () 'split-window-horizontally))
(define-key ctl-x-map	"4"	(or 'shell 'ctl-x-4-prefix)) ;forget prefix!
;;;;(define-key ctl-x-map	"5"	(or () 'OTHER-FRAME-STUFF)) ;???
(define-key ctl-x-map	"6"	(or 'enlarge-window 'TWO-COLUMN-STUFF))
(define-key ctl-x-map	"7"	(or 'compare-windows nil))
(define-key ctl-x-map	"8"	(or 'perl-mode nil))
(define-key ctl-x-map	"9"	(or 'perldb nil))
(define-key ctl-x-map	":"	(or 'lpr-buffer nil))
;;;;(define-key ctl-x-map	";"	(or () 'set-comment-column))
;;;;(define-key ctl-x-map	"<"	(or () 'scroll-left))
;;;;(define-key ctl-x-map	"="	(or () 'what-cursor-position))
;;;;(define-key ctl-x-map	">"	(or () 'scroll-right))
(define-key ctl-x-map	"?"	(or 'lpr-region nil))
;;;;(define-key ctl-x-map	"@"	(or () nil))
;;;;(define-key ctl-x-map	"["	(or () 'backward-page))
(define-key ctl-x-map	"\\"	(or 'electric-command-history nil))
;;;;(define-key ctl-x-map	"]"	(or () 'forward-page))
;;;;(define-key ctl-x-map	"^"	(or () 'enlarge-window))
;;;;(define-key ctl-x-map	"_"	(or () nil))
;;;;(define-key ctl-x-map	"`"	(or () 'next-error))
;;;;(define-key ctl-x-map	"a"	(or () 'append-to-buffer))
;;;;(define-key ctl-x-map	"b"	(or () 'switch-to-buffer))
(define-key ctl-x-map	"c"	(or 'cd nil)) ;???
(define-key ctl-x-map	"d"	(or 'zap-lines 'dired)) ;use ^X^F
;;;;(define-key ctl-x-map	"e"	(or () 'call-last-kbd-macro))
;;;;(define-key ctl-x-map	"f"	(or () 'set-fill-column)) ;none
;;;;(define-key ctl-x-map	"g"	(or () 'insert-register))
;;;;(define-key ctl-x-map	"h"	(or () 'mark-whole-buffer))
(define-key ctl-x-map	"i"	(or 'insert-buffer 'insert-file)) ; ^X^I
;;;;(define-key ctl-x-map	"j"	(or () 'register-to-point))
;;;;(define-key ctl-x-map	"k"	(or () 'kill-buffer))
(define-key ctl-x-map	"l"	(or 'downcase-region 'count-lines-page)) ;^X^L
;;;;(define-key ctl-x-map	"m"	(or () 'mail))
;;;;(define-key ctl-x-map	"n"	(or () 'narrow-to-region))
;;;;(define-key ctl-x-map	"o"	(or () 'other-window))
;;;;(define-key ctl-x-map	"p"	(or () 'narrow-to-page))
;;;;(define-key ctl-x-map	"q"	(or () 'kbd-macro-query))
;;;;(define-key ctl-x-map	"r"	(or () 'copy-rectangle-to-register))
;;;;(define-key ctl-x-map	"s"	(or () 'save-some-buffers))
(define-key ctl-x-map	"t"	(or 'mark-line nil))
(define-key ctl-x-map	"u"	(or 'capitalize-region 'advertised-undo)) ;^X^U
;;;;(define-key ctl-x-map	"v"	(or 'view-file nil))
;;;;(define-key ctl-x-map	"w"	(or () 'widen))
;;;;(define-key ctl-x-map	"x"	(or () 'copy-to-register))
;;;;(define-key ctl-x-map	"y"	(or 'prev-complex-command nil))
;;;;(define-key ctl-x-map	"z"	(or 'rerun-prev-command nil)) ;???
;;;;(define-key ctl-x-map	"{"	(or () 'shrink-window-horizontally))
(define-key ctl-x-map	"|"	(or 'recover-file nil))
;;;;(define-key ctl-x-map	"}"	(or () 'enlarge-window-horizontally))
(define-key ctl-x-map	"~"	(or 'revert-buffer nil))
;;;;(define-key ctl-x-map	"\C-?"	(or () 'backward-kill-sentence))
;;;;
(define-key help-map	"\C-@"	(or 'blackbox nil))
(define-key help-map	"\C-a"	(or 'command-apropos nil))
(define-key help-map	"\C-b"	(or 'describe-bindings nil))
(define-key help-map	"\C-c"	(or 'describe-key-briefly
				    'describe-copying)) ;none
(define-key help-map	"\C-d"	(or 'dup-line 'describe-distribution)) ;none
(define-key help-map	"\C-e"	(or 'call-last-kbd-macro nil))
(define-key help-map	"\C-f"	(or 'describe-function
				    'Info-goto-emacs-command-node)) ; ^Hd
(define-key help-map	"\C-g"	(and 'never nil))
(define-key help-map	"\C-h"	(or () 'help-for-help))
(define-key help-map	"\C-i"	(or 'info nil))
(define-key help-map	"\C-j"	(or 'goto-line nil))
(define-key help-map	"\C-k"	(or 'describe-key
				    'Info-goto-emacs-key-command-node)) ; ^He
(define-key help-map	"\C-l"	(or 'load-library nil))
(define-key help-map	"\C-m"	(or 'describe-mode nil))
(define-key help-map	"\C-n"	(or 'forward-to-indentation 'view-emacs-news))
(define-key help-map	"\C-o"	(or 'display-buffer nil))
(define-key help-map	"\C-p"	(or 'backward-to-indentation nil))
(define-key help-map	"\C-q"	(or 'bugger nil))
(define-key help-map	"\C-r"	(or 'byte-recompile-directory nil))
(define-key help-map	"\C-s"	(or 'describe-syntax nil))
(define-key help-map	"\C-t"	(or 'tick nil))
(define-key help-map	"\C-u"	(or 'describe-c-function nil))
(define-key help-map	"\C-v"	(or 'describe-variable nil))
(define-key help-map	"\C-w"	(or 'where-is 'describe-no-warranty)) ;none
(define-key help-map	"\C-x"	(or 'ding nil))
(define-key help-map	"\C-y"	(or 'random-yow nil))
(define-key help-map	"\C-z"	(or () nil))
(define-key help-map	"\C-["	(or 'start-kbd-macro nil))
(define-key help-map	"\C-\\"	(or 'never nil))
(define-key help-map	"\C-]"	(or 'end-kbd-macro nil))
(define-key help-map	"\C-^"	(or 'never nil))
(define-key help-map	"\C-_"	(or () nil))
;;;;
(define-key help-map	" "	(or 'delete-horizontal-space nil))
;;;;(define-key help-map	"!"	(or 'gdb nil))
;;;;(define-key help-map	"\""	(or () nil))
(define-key help-map	"#"	(or 'server-start nil))
;;;;(define-key help-map	"$"	(or () nil))
;;;;(define-key help-map	"%"	(or () nil))
;;;;(define-key help-map	"&"	(or () nil))
;;;;(define-key help-map	"'"	(or 'unexpand-abbrev nil))
;;;;(define-key help-map	"("	(or () nil))
;;;;(define-key help-map	")"	(or () nil))
(define-key help-map	"*"	(or 'set-variable nil))
;;;;(define-key help-map	"+"	(or 'add-mode-abbrev nil))
;;;;(define-key help-map	","	(or () nil))
;;;;(define-key help-map	"-"	(or 'inverse-add-mode-abbrev nil))
(define-key help-map	"."	(or 'find-tag-other-window nil))
(define-key help-map	"/"	(or 'expand-region-abbrevs nil))
;;;;(define-key help-map	"0"	(or () nil))
;;;;(define-key help-map	"1"	(or () nil))
;;;;(define-key help-map	"2"	(or () nil))
;;;;(define-key help-map	"3"	(or () nil))
;;;;(define-key help-map	"4"	(or () nil))
;;;;(define-key help-map	"5"	(or () nil))
;;;;(define-key help-map	"6"	(or () nil))
;;;;(define-key help-map	"7"	(or () nil))
;;;;(define-key help-map	"8"	(or () nil))
;;;;(define-key help-map	"9"	(or () nil))
(define-key help-map	":"	(or 'sort-colon nil))
(define-key global-map	[?\M-\C-\;]
(define-key help-map	";"	(or 'kill-comment nil))
)
;;;;(define-key help-map	"<"	(or () nil))
(define-key help-map	"="	(or 'what-page nil))
;;;;(define-key help-map	">"	(or () nil))
;;;;(define-key help-map	"?"	(or () 'help-for-help))
;;;;
;;;;(define-key help-map	"@"	(or () nil))
;;;;(define-key help-map	"["	(or () nil))
;;;;(define-key help-map	"\\"	(or () nil))
;;;;(define-key help-map	"]"	(or () nil))
;;;;(define-key help-map	"^"	(or () nil))
;;;;(define-key help-map	"_"	(or () nil))
(define-key help-map	"`"	(or 'bell nil))
(define-key help-map	"a"	(or 'apropos 'command-apropos))	;^H^A
(define-key help-map	"b"	(or 'switch-to-buffer-other-window
				    'describe-bindings)) ;^H^B
(define-key help-map	"c"	(or 'compile 'describe-key-briefly)) ;^H^C
(define-key help-map	"d"	(or 'Info-goto-emacs-command-node
				    'describe-function)) ;use ^Hf
(define-key help-map	"e"	(or 'Info-goto-emacs-key-command-node nil))
(define-key help-map	"f"	(or 'find-file-other-window
				    'describe-function)) ;^H^F
(define-key help-map	"g"	(or 'grep nil))
;;;;(define-key help-map	"h"	(or 'rmail-header-clean nil)) ;;rmail mode
;;;;(define-key help-map	"i"	(or () 'info))
(define-key help-map	"j"	(or 'goto-char nil))
;;;;(define-key help-map	"k"	(or 'kill-rectangle 'describe-key)) ;^H^K
(define-key help-map	"l"	(or 'list-tags 'view-lossage)) ;none
(define-key help-map	"m"	(or 'man
				    'describe-mode)) ;^H^M
(define-key help-map	"n"	(or 'next-file 'view-emacs-news)) ;none
(define-key help-map	"o"	(or 'occur-sorted nil))
;;;;(define-key help-map	"p"	(or () nil))
;;;;(define-key help-map	"q"	(or 'tags-query-replace nil))
;;;;(define-key help-map	"r"	(or 'rmail-summary-sort nil)) ;;rmail summary
(define-key help-map	"s"	(or 'tags-search 'describe-syntax)) ;^H^S
(define-key help-map	"t"	(or 'tags-apropos 'help-with-tutorial))	;none
(define-key help-map	"u"	(or 'buffer-enable-undo nil))
(define-key help-map	"v"	(or 'visit-tags-table 'describe-variable));^H^V
;;;;(define-key help-map	"w"	(or () 'where-is))
;;;;(define-key help-map	"x"	(or () nil))
;;;;(define-key help-map	"y"	(or 'yank-rectangle nil))
;;;;(define-key help-map	"z"	(or () nil))
;;;;(define-key help-map	"{"	(or () nil))
;;;;(define-key help-map	"|"	(or () nil))
;;;;(define-key help-map	"}"	(or () nil))
;;;;(define-key help-map	"~"	(or () nil))
;;;;(define-key help-map	"\C-?"	(or 'backward-delete-untabify nil))
