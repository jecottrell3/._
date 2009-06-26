(let ((rbj (expand-file-name "~jcottrell/emacs")))
  (or (member rbj load-path)
      (setq load-path (cons rbj load-path))))

(load "vars-19")				; setq only
(load "fns-19")				; defun, fset, autoload only
(load "bondage-19")			; def-key only NEW
;;;;(load "term-hook")			; {sun,vt[12]00,tvi950}-hook
;;;;(load "find-files")			; I never use it
(load "eehelp")			; electric help rbj style
;;;;(load "info")			; get info
;;;;(load "info-hook")			; customize
(load "uncompress")
(load "vc-hooks")			; BUG!
;;;;;;;;(load "~kyle/lisp/execcmd")
;;;;;;;;(load "blackbox")			; have some fun
(display-time)
(if window-system
    (progn
      (require 'hilit19)
      (require 'paren)
      (require 'avoid)
      (transient-mark-mode 1)
      ))
(message "VERSION 19")
(sit-for 2)
