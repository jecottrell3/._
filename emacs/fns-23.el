;23-;;;;;;; Trivial Functions
;23-
;23-;;;;(fset 'rubout-char	(setq rubout-char	"\^b\^d"))
;23-;;;;(fset 'rubout-line	(setq rubout-line	"\e0\^k"))
;23-;;;;(fset 'join-line	(setq join-line		"\e1\^k"))
;23-;;;;(fset 'line-to-top	(setq line-to-top	"\e0\^l"))
;23-;;;;(fset 'line-to-bot	(setq line-to-bot	"\e-\^l"))
;23-
;23-;;;;;;; Autoloads
;23-
;23-(autoload
;23- 'describe-c-function	"c-hook"	"C Interface to manual-entry" t)
;23-;;;;(autoload 'c++-mode	"c++-mode"	"C++ mode" t)
;23-;;;;(autoload 'c++-c-mode	"c++-mode"	"C mode" t)
;23-;;;;(autoload 'random-yow	"shaker"	"Zippy on vt100." t) ;^H^Y
;23-;;;;(autoload 'next-error	"compile-hook"	"New next error." t) ; ^X` & ^Hn
;23-;;;;(autoload 'compile	"compile-hook"	"New compile." t) ; ^Hc
;23-;;;;(autoload 'grep		"compile-hook"	"New grep." t) ; ^Hg
;23-;;;;(autoload 'mail-quote	"mail-hook"	"Rip off header & quote body") ; \e""
;23-
;23-;;;;(autoload 'yowza	"mail-hook"	"Region to Zippy quote" t) ; ^X^Y
;23-
;23-(autoload 'ro-mode	"ro-mode"	"Read Only mode." t nil) ; ^X^R
;23-;;;;(autoload 'stty		"stty"		"Display stty settings." t nil)
;23-
;23-;;;;;;; Stuff from Kyle
;23-
;23-(autoload 'vm "vm" "Start VM on your primary inbox." t)
;23-(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
;23-(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
;23-(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
;23-(autoload 'vm-mail "vm" "Send a mail message using VM." t)
;23-(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)
;23-
;23-;;;;(autoload 'vkill "~kyle/lisp/vkill" nil t)
;23-;;;;;;;;(autoload 'list-unix-processes "~kyle/lisp/vkill" nil t)
;23-
;23-;;;;;;; Hooks
;23-
;23-(autoload 'c-mode-hook		"c-hook"	"C     Mode Hook")
;23-(autoload 'c++-mode-hook	"c-hook"	"C++   Mode Hook")
;23-(autoload 'dired-load-hook	"dired-hook-23"	"Dired Load Hook")
;23-(autoload 'dired-mode-hook	"dired-hook-23"	"Dired Mode Hook")
;23-(autoload 'Info-mode-hook	"info-hook"	"Info Mode Hook")
;23-(autoload 'isearch-mode-hook	"isearch-hook"	"Isearch Mode Hook")
;23-(autoload 'comint-mode-hook	"shell-hook"	"Command Modes")
;23-(autoload 'gud-mode-hook	"shell-hook"	"Debugging")
;23-(autoload 'shell-mode-hook	"shell-hook"	"Shell Mode Hook")
;23-;;;;(autoload   'gdb-mode-hook	"shell-hook"  	"GDB   Mode Hook")
;23-;;;;(autoload 'perldb-mode-hook	"shell-hook"  	"Perl Debug Hook")
;23-;;;;(autoload 'view-hook		"view-hook"	"View  Mode Hook")
;23-;;;;(autoload  'mail-mode-hook	"mail-hook" 	"Mail  Mode Hook")
;23-;;;;(autoload 'rmail-mode-hook	"mail-hook"	"Rmail Mode Hook")
;23-;;;;(autoload
;23-;;;; 'rmail-summary-mode-hook	"mail-hook"	"Rmail Summary Mode Hook")
;23-
;23-(defun buffer-menu-mode-hook ()
;23-  "Add motion commands in buffer-menu mode"
;23-  (tick)
;23-  (define-key Buffer-menu-mode-map "\t" 'previous-line)
;23-;;;;  (define-key Buffer-menu-mode-map "p"  'previous-line)
;23-;;;;  (define-key Buffer-menu-mode-map "n"  'next-line)
;23-  (define-key Buffer-menu-mode-map "\r" 'next-line)
;23-  (define-key Buffer-menu-mode-map "\n" 'next-line)
;23-  (setq buffer-menu-mode-hook nil))
;23-
;23-(defun blink-paren-hook ()
;23-  "Blink, then move-past-close-and-reindent"
;23-  (if (and (not (eobp))
;23-	   (char-equal (char-after (point)) last-input-char))
;23-      (delete-char 1))
;23-  (blink-matching-open))
;23-
;23-(defun blink-paren ()			; ^X^]
;23-  "Interactive wrapper for blink-matching-open"
;23-  (interactive)
;23-  (blink-matching-open))
;23-
;23-(defun find-file-hook ()
;23-  (and buffer-read-only (ro-mode 1)))
;23-
;23-
;23-;;; Random Functions
;23-
;23-(if (fboundp 'backward-delete-untabify)
;23-    ()
;23-  (fset 'backward-delete-untabify
;23-	(symbol-function 'backward-delete-char-untabify))
;23-  (fset 'backward-delete-char-untabify
;23-	(symbol-function 'delete-backward-char))
;23-)
;23-
;23-(defun scroll-other-window-down (arg)	; \e^]
;23-  "Just what it says"
;23-  (interactive	"P")
;23-  (scroll-other-window
;23-   (cond ((null arg) '-)
;23-	 ((eq arg '-) nil)
;23-	 (t (- (prefix-numeric-value arg))))))
;23-
;23-;;;;(defun rmail-file (file)		; ^X^M
;23-;;;;  "Invoke rmail on a given file"
;23-;;;;  (interactive "FRmail file: ")
;23-;;;;  (rmail file))
;23-
;23-(defun mark-line (arg)			; ^Xt
;23-  "Copy ARG lines as kill."
;23-  (interactive "p")
;23-  (save-excursion
;23-    (forward-line 0)
;23-    (copy-region-as-kill
;23-     (point)
;23-     (progn (forward-line arg) (point)))))
;23-
;23-(defun dup-line (arg)			; ^H^D
;23-  "Duplicate this line"
;23-  (interactive "*p")
;23-  (let ((point (point)))
;23-    (beginning-of-line 1)
;23-    (kill-line arg)
;23-    (yank) (yank)
;23-    (setq this-command 'dup-line)	; yank sets this-command
;23-    (goto-char point)))
;23-
;23-(defun sort-colon (beg end num)		; ^H:
;23-  "Run region (BEG to END) thru 'sort -t: +1'.
;23-Sort numerically if any prefix (NUM) is given."
;23-  (interactive "*r\nP")
;23-  (shell-command-on-region beg end (concat "sort -t: +1" (if num "n" "")) t))
;23-
;23-(defun occur-sorted (regexp)		; ^Ho
;23-  "Like occur, only sort the buffer"
;23-  (interactive "sSorted lines matching regexp: ")
;23-  (occur regexp)
;23-  (switch-to-buffer-other-window "*Occur*")
;23-  (sort-colon 1 (point-max) nil)
;23-  (goto-char 1)
;23-  (other-window 1))
;23-
;23-(defun bell ()
;23-  "Well ring my chimes!"
;23-  (interactive)
;23-  (send-string-to-terminal "\^g"))
;23-
;23-;;;;(defun read-keymap (&optional prompt)
;23-;;;;  "RMS forgot this function"
;23-;;;;  (interactive)
;23-;;;;  (completing-read 
;23-;;;;   (or prompt "Keymap name: ")
;23-;;;;   obarray 'keymapp t))
;23-
;23-;;;;(defun read-symbol (&optional prompt)
;23-;;;;  "RMS forgot this function"
;23-;;;;  (interactive)
;23-;;;;  (completing-read 
;23-;;;;   (or prompt "Variable name: ")
;23-;;;;   obarray 'symbolp t))
;23-
;23-;;;;(defvar universal-power 4 "*Arg to multiply by for ^U.")
;23-;;;;(defun universal-argument ()
;23-;;;;  "Begin a numeric argument for the following command.
;23-;;;;Digits or minus sign following this command make up the numeric argument.
;23-;;;;If no digits or minus sign follow, this command provides 4 as argument.
;23-;;;;Used more than once, this command multiplies the argument by 4 each time."
;23-;;;;  (interactive nil)
;23-;;;;  (let ((c-u universal-power) (argstartchar last-command-char)
;23-;;;;	char)
;23-;;;;    (setq char (read-char))
;23-;;;;    (while (= char argstartchar)
;23-;;;;      (setq c-u (* universal-power c-u))
;23-;;;;      (setq char (read-char)))
;23-;;;;    (prefix-arg-internal char c-u nil)))
;23-
;23-;;;;(defun prefix-arg-internal (char c-u value)
;23-;;;;  (let ((sign 1) (base 10) (digits "[0-9]"))
;23-;;;;    (if (and (numberp value) (< value 0))
;23-;;;;	(setq sign -1 value (- value)))
;23-;;;;    (if (eq value '-)
;23-;;;;	(setq sign -1 value nil))
;23-;;;;					;   (describe-arg value sign)
;23-;;;;    (while (= ?- char)
;23-;;;;      (setq sign (- sign) c-u nil)
;23-;;;;					;     (describe-arg value sign)
;23-;;;;      (setq char (read-char)))
;23-;;;;    (and (= char 19)
;23-;;;;	 (setq base 16 digits "[0-9a-fA-F]")
;23-;;;;	 (setq char (read-char)))
;23-;;;;    (while (string-match digits (char-to-string char))
;23-;;;;      (and (> char ?9) (setq char (+ 9 char)))
;23-;;;;      (setq value (+ (* (if (numberp value) value 0) base)
;23-;;;;		     (logand 15 char)) c-u nil)
;23-;;;;					;     (describe-arg value sign)
;23-;;;;      (setq char (read-char)))
;23-;;;;    (setq prefix-arg
;23-;;;;	  (cond (c-u (list c-u))
;23-;;;;		((numberp value) (* value sign))
;23-;;;;		((= sign -1) '-)))
;23-;;;;    (setq unread-command-char char)))
;23-
;23-;;;;;;; Stolen from lisp/term/sun.el
;23-
;23-;;;;(defun scroll-up-in-place (n)		; ^X8
;23-;;;;  (interactive "p")
;23-;;;;  (scroll-up n)
;23-;;;;  (next-line n))
;23-
;23-;;;;(defun scroll-down-in-place (n)		; ^X9
;23-;;;;  (interactive "p")
;23-;;;;  (scroll-down n)
;23-;;;;  (previous-line n))
;23-
;23-;;;;(defun prev-complex-command ()		; ^Xy
;23-;;;;  "Select Previous-complex-command"
;23-;;;;  (interactive)
;23-;;;;  (if (zerop (minibuffer-depth))
;23-;;;;      (repeat-complex-command 1)
;23-;;;;    (previous-complex-command 1)))
;23-
;23-;;;;(defun rerun-prev-command ()		; ^Xz
;23-;;;;  "Repeat Previous-complex-command."
;23-;;;;  (interactive)
;23-;;;;  (eval (nth 0 command-history)))
;23-
;23-;;;;(defun transpose-keys (src dst)
;23-;;;;  "In keyboard-translate-table, translate SRC to DST."
;23-;;;;  (interactive "nMap: \nnto: ")
;23-;;;;  (if (y-or-n-p
;23-;;;;       (format "Map %c to %c? " src dst))
;23-;;;;      (aset keyboard-translate-table src dst)))
;23-
;23-;;;;(defun LFD (arg)
;23-;;;;  "Fake a LINE FEED char."
;23-;;;;  (interactive "P")
;23-;;;;  (setq prefix-arg current-prefix-arg
;23-;;;;	this-command last-command
;23-;;;;	unread-command-char ?\n))
;23-
;23-(defun zap-lines (arg &optional regexp)
;23-  "Flush Lines (or Keep if prefix ARG) containing REGEXP."
;23-  (interactive "P")
;23-  (funcall (if arg 'keep-lines 'flush-lines)
;23-	   (or regexp (read-string 
;23-		       (concat (if arg "Keep" "Flush")
;23-			       " lines matching: ")))))
;23-
;23-(defun manual (topic)
;23-  "Like manual-entry, but rename and select buffer."
;23-  (interactive "sManual topic? ")
;23-  (let ((name (concat "*Manual-" topic "*")))
;23-    (if (get-buffer name)
;23-	nil
;23-      (manual-entry topic)
;23-      (set-buffer (format "*man %s*" topic))
;23-      (rename-buffer name)
;23-      (ro-mode 1))
;23-    (select-window (display-buffer name))))
;23-
;23-(defun erase-buf ()
;23-  "Interactive version of erase-buffer."
;23-  (interactive)
;23-  (erase-buffer))
;23-
;23-(defun hack-local-variables-command ()
;23-  "Interactive version of hack-local-variables"
;23-  (interactive)
;23-  (hack-local-variables)
;23-  (message "local variables hacked."))
;23-
;23-(defun what-cursor-position ()
;23-  "Print info on cursor position (on screen and within buffer)."
;23-  (interactive)
;23-  (let* ((char (following-char))
;23-	 (beg (point-min))
;23-	 (end (point-max))
;23-         (pos (point))
;23-	 (total (buffer-size))
;23-	 (percent (if (> total 50000)
;23-		      ;; Avoid overflow from multiplying by 100!
;23-		      (/ (+ (/ total 200) (1- pos)) (max (/ total 100) 1))
;23-		    (/ (+ (/ total 2) (* 100 (1- pos))) (max total 1))))
;23-	 (hscroll (if (= (window-hscroll) 0)
;23-		      ""
;23-		    (format " Hscroll=%d" (window-hscroll))))
;23-	 (col (current-column)))
;23-    (if (= pos end)
;23-	(if (or (/= beg 1) (/= end (1+ total)))
;23-	    (message "point=%d of %d(%d%%) <%d - %d>  column %d %s"
;23-		     pos total percent beg end col hscroll)
;23-	  (message "point=%d of %d(%d%%)  column %d %s"
;23-		   pos total percent col hscroll))
;23-      (if (or (/= beg 1) (/= end (1+ total)))
;23-	  (message "Char: %s (0%o, %d, 0x%x)  point: (%d, 0x%x) of %d(%d%%) <%d - %d>  column %d %s"
;23-		   (single-key-description char) char char char pos pos total percent beg end col hscroll)
;23-	(message "Char: %s (0%o, %d, 0x%x)  point: (%d, 0x%x) of %d(%d%%)  column %d %s"
;23-		 (single-key-description char) char char char pos pos total percent col hscroll)))))
;23-
;23-(defun bugger (fun)
;23-  "Flip debugging mode on FUN.
;23-If T or NIL, assign to variable debug-on-error"
;23-  (interactive "SFunction: ")
;23-  (if (fboundp fun)
;23-	(if (assq 'debug (symbol-function fun))
;23-	    (cancel-debug-on-entry fun)
;23-	  (debug-on-entry fun))
;23-    (setq debug-on-error fun debug-on-quit fun)))
