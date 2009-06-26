;;;;;;; Trivial Functions

;;;;(fset 'rubout-char	(setq rubout-char	"\^b\^d"))
;;;;(fset 'rubout-line	(setq rubout-line	"\e0\^k"))
;;;;(fset 'join-line	(setq join-line		"\e1\^k"))
;;;;(fset 'line-to-top	(setq line-to-top	"\e0\^l"))
;;;;(fset 'line-to-bot	(setq line-to-bot	"\e-\^l"))

;;;;;;; Autoloads

(autoload
 'describe-c-function	"c-hook"	"C Interface to manual-entry" t)
;;;;(autoload 'c++-mode	"c++-mode"	"C++ mode" t)
;;;;(autoload 'c++-c-mode	"c++-mode"	"C mode" t)
;;;;(autoload 'random-yow	"shaker"	"Zippy on vt100." t) ;^H^Y
;;;;(autoload 'next-error	"compile-hook"	"New next error." t) ; ^X` & ^Hn
;;;;(autoload 'compile	"compile-hook"	"New compile." t) ; ^Hc
;;;;(autoload 'grep		"compile-hook"	"New grep." t) ; ^Hg
;;;;(autoload 'mail-quote	"mail-hook"	"Rip off header & quote body") ; \e""

;;;;(autoload 'yowza	"mail-hook"	"Region to Zippy quote" t) ; ^X^Y

(autoload 'ro-mode	"ro-mode"	"Read Only mode." t nil) ; ^X^R
;;;;(autoload 'stty		"stty"		"Display stty settings." t nil)

;;;;;;; Stuff from Kyle

(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)

;;;;(autoload 'vkill "~kyle/lisp/vkill" nil t)
;;;;;;;;(autoload 'list-unix-processes "~kyle/lisp/vkill" nil t)

;;;;;;; Hooks

(autoload 'c-mode-hook		"c-hook"	"C     Mode Hook")
(autoload 'c++-mode-hook	"c-hook"	"C++   Mode Hook")
(autoload 'dired-load-hook	"dired-hook-19"	"Dired Load Hook")
(autoload 'dired-mode-hook	"dired-hook-19"	"Dired Mode Hook")
(autoload 'Info-mode-hook	"info-hook"	"Info Mode Hook")
(autoload 'isearch-mode-hook	"isearch-hook"	"Isearch Mode Hook")
(autoload 'comint-mode-hook	"shell-hook"	"Command Modes")
(autoload 'gud-mode-hook	"shell-hook"	"Debugging")
(autoload 'shell-mode-hook	"shell-hook"	"Shell Mode Hook")
;;;;(autoload   'gdb-mode-hook	"shell-hook"  	"GDB   Mode Hook")
;;;;(autoload 'perldb-mode-hook	"shell-hook"  	"Perl Debug Hook")
;;;;(autoload 'view-hook		"view-hook"	"View  Mode Hook")
;;;;(autoload  'mail-mode-hook	"mail-hook" 	"Mail  Mode Hook")
;;;;(autoload 'rmail-mode-hook	"mail-hook"	"Rmail Mode Hook")
;;;;(autoload
;;;; 'rmail-summary-mode-hook	"mail-hook"	"Rmail Summary Mode Hook")

(defun buffer-menu-mode-hook ()
  "Add motion commands in buffer-menu mode"
  (tick)
  (define-key Buffer-menu-mode-map "\t" 'previous-line)
;;;;  (define-key Buffer-menu-mode-map "p"  'previous-line)
;;;;  (define-key Buffer-menu-mode-map "n"  'next-line)
  (define-key Buffer-menu-mode-map "\r" 'next-line)
  (define-key Buffer-menu-mode-map "\n" 'next-line)
  (setq buffer-menu-mode-hook nil))

(defun blink-paren-hook ()
  "Blink, then move-past-close-and-reindent"
  (if (and (not (eobp))
	   (char-equal (char-after (point)) last-input-char))
      (delete-char 1))
  (blink-matching-open))

(defun blink-paren ()			; ^X^]
  "Interactive wrapper for blink-matching-open"
  (interactive)
  (blink-matching-open))

(defun find-file-hook ()
  (and buffer-read-only (ro-mode 1)))


;;; Random Functions

(if (fboundp 'backward-delete-untabify)
    ()
  (fset 'backward-delete-untabify
	(symbol-function 'backward-delete-char-untabify))
  (fset 'backward-delete-char-untabify
	(symbol-function 'delete-backward-char))
)

(defun scroll-other-window-down (arg)	; \e^]
  "Just what it says"
  (interactive	"P")
  (scroll-other-window
   (cond ((null arg) '-)
	 ((eq arg '-) nil)
	 (t (- (prefix-numeric-value arg))))))

;;;;(defun rmail-file (file)		; ^X^M
;;;;  "Invoke rmail on a given file"
;;;;  (interactive "FRmail file: ")
;;;;  (rmail file))

(defun mark-line (arg)			; ^Xt
  "Copy ARG lines as kill."
  (interactive "p")
  (save-excursion
    (forward-line 0)
    (copy-region-as-kill
     (point)
     (progn (forward-line arg) (point)))))

(defun dup-line (arg)			; ^H^D
  "Duplicate this line"
  (interactive "*p")
  (let ((point (point)))
    (beginning-of-line 1)
    (kill-line arg)
    (yank) (yank)
    (setq this-command 'dup-line)	; yank sets this-command
    (goto-char point)))

(defun sort-colon (beg end num)		; ^H:
  "Run region (BEG to END) thru 'sort -t: +1'.
Sort numerically if any prefix (NUM) is given."
  (interactive "*r\nP")
  (shell-command-on-region beg end (concat "sort -t: +1" (if num "n" "")) t))

(defun occur-sorted (regexp)		; ^Ho
  "Like occur, only sort the buffer"
  (interactive "sSorted lines matching regexp: ")
  (occur regexp)
  (switch-to-buffer-other-window "*Occur*")
  (sort-colon 1 (point-max) nil)
  (goto-char 1)
  (other-window 1))

(defun bell ()
  "Well ring my chimes!"
  (interactive)
  (send-string-to-terminal "\^g"))

;;;;(defun read-keymap (&optional prompt)
;;;;  "RMS forgot this function"
;;;;  (interactive)
;;;;  (completing-read 
;;;;   (or prompt "Keymap name: ")
;;;;   obarray 'keymapp t))

;;;;(defun read-symbol (&optional prompt)
;;;;  "RMS forgot this function"
;;;;  (interactive)
;;;;  (completing-read 
;;;;   (or prompt "Variable name: ")
;;;;   obarray 'symbolp t))

;;;;(defvar universal-power 4 "*Arg to multiply by for ^U.")
;;;;(defun universal-argument ()
;;;;  "Begin a numeric argument for the following command.
;;;;Digits or minus sign following this command make up the numeric argument.
;;;;If no digits or minus sign follow, this command provides 4 as argument.
;;;;Used more than once, this command multiplies the argument by 4 each time."
;;;;  (interactive nil)
;;;;  (let ((c-u universal-power) (argstartchar last-command-char)
;;;;	char)
;;;;    (setq char (read-char))
;;;;    (while (= char argstartchar)
;;;;      (setq c-u (* universal-power c-u))
;;;;      (setq char (read-char)))
;;;;    (prefix-arg-internal char c-u nil)))

;;;;(defun prefix-arg-internal (char c-u value)
;;;;  (let ((sign 1) (base 10) (digits "[0-9]"))
;;;;    (if (and (numberp value) (< value 0))
;;;;	(setq sign -1 value (- value)))
;;;;    (if (eq value '-)
;;;;	(setq sign -1 value nil))
;;;;					;   (describe-arg value sign)
;;;;    (while (= ?- char)
;;;;      (setq sign (- sign) c-u nil)
;;;;					;     (describe-arg value sign)
;;;;      (setq char (read-char)))
;;;;    (and (= char 19)
;;;;	 (setq base 16 digits "[0-9a-fA-F]")
;;;;	 (setq char (read-char)))
;;;;    (while (string-match digits (char-to-string char))
;;;;      (and (> char ?9) (setq char (+ 9 char)))
;;;;      (setq value (+ (* (if (numberp value) value 0) base)
;;;;		     (logand 15 char)) c-u nil)
;;;;					;     (describe-arg value sign)
;;;;      (setq char (read-char)))
;;;;    (setq prefix-arg
;;;;	  (cond (c-u (list c-u))
;;;;		((numberp value) (* value sign))
;;;;		((= sign -1) '-)))
;;;;    (setq unread-command-char char)))

;;;;;;; Stolen from lisp/term/sun.el

;;;;(defun scroll-up-in-place (n)		; ^X8
;;;;  (interactive "p")
;;;;  (scroll-up n)
;;;;  (next-line n))

;;;;(defun scroll-down-in-place (n)		; ^X9
;;;;  (interactive "p")
;;;;  (scroll-down n)
;;;;  (previous-line n))

;;;;(defun prev-complex-command ()		; ^Xy
;;;;  "Select Previous-complex-command"
;;;;  (interactive)
;;;;  (if (zerop (minibuffer-depth))
;;;;      (repeat-complex-command 1)
;;;;    (previous-complex-command 1)))

;;;;(defun rerun-prev-command ()		; ^Xz
;;;;  "Repeat Previous-complex-command."
;;;;  (interactive)
;;;;  (eval (nth 0 command-history)))

;;;;(defun transpose-keys (src dst)
;;;;  "In keyboard-translate-table, translate SRC to DST."
;;;;  (interactive "nMap: \nnto: ")
;;;;  (if (y-or-n-p
;;;;       (format "Map %c to %c? " src dst))
;;;;      (aset keyboard-translate-table src dst)))

;;;;(defun LFD (arg)
;;;;  "Fake a LINE FEED char."
;;;;  (interactive "P")
;;;;  (setq prefix-arg current-prefix-arg
;;;;	this-command last-command
;;;;	unread-command-char ?\n))

(defun zap-lines (arg &optional regexp)
  "Flush Lines (or Keep if prefix ARG) containing REGEXP."
  (interactive "P")
  (funcall (if arg 'keep-lines 'flush-lines)
	   (or regexp (read-string 
		       (concat (if arg "Keep" "Flush")
			       " lines matching: ")))))

(defun manual (topic)
  "Like manual-entry, but rename and select buffer."
  (interactive "sManual topic? ")
  (let ((name (concat "*Manual-" topic "*")))
    (if (get-buffer name)
	nil
      (manual-entry topic)
      (set-buffer (format "*man %s*" topic))
      (rename-buffer name)
      (ro-mode 1))
    (select-window (display-buffer name))))

(defun erase-buf ()
  "Interactive version of erase-buffer."
  (interactive)
  (erase-buffer))

(defun hack-local-variables-command ()
  "Interactive version of hack-local-variables"
  (interactive)
  (hack-local-variables)
  (message "local variables hacked."))

(defun what-cursor-position ()
  "Print info on cursor position (on screen and within buffer)."
  (interactive)
  (let* ((char (following-char))
	 (beg (point-min))
	 (end (point-max))
         (pos (point))
	 (total (buffer-size))
	 (percent (if (> total 50000)
		      ;; Avoid overflow from multiplying by 100!
		      (/ (+ (/ total 200) (1- pos)) (max (/ total 100) 1))
		    (/ (+ (/ total 2) (* 100 (1- pos))) (max total 1))))
	 (hscroll (if (= (window-hscroll) 0)
		      ""
		    (format " Hscroll=%d" (window-hscroll))))
	 (col (current-column)))
    (if (= pos end)
	(if (or (/= beg 1) (/= end (1+ total)))
	    (message "point=%d of %d(%d%%) <%d - %d>  column %d %s"
		     pos total percent beg end col hscroll)
	  (message "point=%d of %d(%d%%)  column %d %s"
		   pos total percent col hscroll))
      (if (or (/= beg 1) (/= end (1+ total)))
	  (message "Char: %s (0%o, %d, 0x%x)  point: (%d, 0x%x) of %d(%d%%) <%d - %d>  column %d %s"
		   (single-key-description char) char char char pos pos total percent beg end col hscroll)
	(message "Char: %s (0%o, %d, 0x%x)  point: (%d, 0x%x) of %d(%d%%)  column %d %s"
		 (single-key-description char) char char char pos pos total percent col hscroll)))))

(defun bugger (fun)
  "Flip debugging mode on FUN.
If T or NIL, assign to variable debug-on-error"
  (interactive "SFunction: ")
  (if (fboundp fun)
	(if (assq 'debug (symbol-function fun))
	    (cancel-debug-on-entry fun)
	  (debug-on-entry fun))
    (setq debug-on-error fun debug-on-quit fun)))
