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

(autoload 'vm "vm" nil t)
(autoload 'vm-mode "vm" nil t)
(autoload 'vm-visit-folder "vm" nil t)
(autoload 'vm-visit-virtual-folder "vm-virtual" nil t)
(autoload 'vm-mail "vm-reply" nil t)
;;;;(autoload 'vkill "~kyle/lisp/vkill" nil t)
;;;;(autoload 'list-unix-processes "~kyle/lisp/vkill" nil t)

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

(defun uncompress-while-visiting-ro ()
  "uncompress-while-visiting, then set ro-mode"
  (uncompress-while-visiting)
  (ro-mode t)
  (goto-char (point-min)))

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
    (kill-