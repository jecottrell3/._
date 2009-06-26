(defun comint-mode-hook ()
  "Fix some bindings."
  (interactive)
  (shell-keys)
)

(defun gud-mode-hook ()
  "Fix some bindings."
  (interactive)
  (shell-keys)
)

(defun select-shell ()
  "Select the shell buffer"
  (interactive)
  (switch-to-buffer "shell"))

(defun shell-mode-hook ()
  "Shell mode customization."
  (shell-keys)
  (define-key global-map "\C-x4" 'select-shell)
  (rename-buf "shell")
  ;;(setq shell-mode-hook nil)
)

;;;;(defun perldb-mode-hook ()
;;;;  "Hooks for expanding filenames in perldb mode"
;;;;  ;;  (shell-keys)
;;;;  ;;  (def-perldb "r"   "\M-r" "Return from current subroutine")
;;;;  ;;  (rename-buf "perldb")
;;;;  ;;(setq perldb-mode-hook nil)
;;;;)

(defun shell-keys ()
  "Define the following keys in MAP, for shell and gdb modes."
  (tick)
  (local-set-key "\C-a" nil)
  (local-set-key "\C-v" 'comint-bol)
  ;;  (local-set-key "\M-p" nil)
  ;;  (local-set-key "\M-n" nil)
  (local-set-key "\C-c\C-q" 'comint-quit-subjob)
  (local-set-key "\C-c\C-v" 'comint-show-output)
  (local-set-key "\C-c\C-k" 'erase-buf)
)

;;;;(defun gdb-mode-hook ()
;;;;  "Do shell hooks in gdb mode"
;;;;  (shell-keys)
;;;;  (define-key gdb-mode-map "\C-l" 'gdb-refresh)
;;;;  (rename-buf "gdb")
;;;;  (end-of-buffer)
;;;;  (set-buffer-modified-p (buffer-modified-p))
;;;;)

(defun rename-buf (name)
  "Like (rename-buffer NAME), but try suffixes."
  (interactive "BRename Buf: ")
  (if (get-buffer name)
      (let ((n -1))
	(while (get-buffer (concat name n))
	  (setq n (1- n)))
	(setq name (concat name n))))
  (rename-buffer name))
