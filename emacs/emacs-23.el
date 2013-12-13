;23-(let ((rbj (expand-file-name "~/emacs")))
;23-  (or (member rbj load-path)
;23-      (setq load-path (cons rbj load-path))))
;23-
;23-(load "vars-23")				; setq only
;23-(load "fns-23")				; defun, fset, autoload only
;23-(load "bondage-23")			; def-key only NEW
;23-;;;;(load "term-hook")			; {sun,vt[12]00,tvi950}-hook
;23-;;;;(load "find-files")			; I never use it
;23-(load "eehelp")			; electric help rbj style
;23-;;;;(load "info")			; get info
;23-;;;;(load "info-hook")			; customize
;23-;;;;(load "uncompress")
;23-(load "vc-hooks")			; BUG!
;23-;;;;;;;;(load "~kyle/lisp/execcmd")
;23-;;;;;;;;(load "blackbox")			; have some fun
;23-(display-time)
;23-(if window-system
;23-    (progn
;23-      (require 'hilit19)
;23-      (require 'paren)
;23-      (require 'avoid)
;23-      (transient-mark-mode 1)
;23-      ))
;23-(message "VERSION 23")
;23-(sit-for 2)
