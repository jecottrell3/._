(defvar default-c-indent 4
  "*Indent by this amount")

(defun c-mode-hook (&optional arg)
  "Set indents to ARG. Use BSD style, or GNU if ARG is negative."
  (interactive "P")
  (setq arg (if arg (prefix-numeric-value arg)
	      (setq arg default-c-indent)))
  (if (< arg 0)
      (setq arg (- arg)
	    c-brace-offset 0
	    c-auto-newline t)
    (setq c-brace-offset (- arg)
	  c-auto-newline nil))
  (setq c-argdecl-indent arg)
  (setq c-brace-imaginary-offset 0)
  (setq c-continued-brace-offset 0)
  (setq c-continued-statement-offset arg)
  (setq c-indent-level arg)
  (setq c-label-offset (- arg))
  ;;(setq c-mode-abbrev-table)
  ;;(setq c-mode-map)
  ;;(setq c-mode-syntax-table)
  (setq c-tab-always-indent t)
  (setq comment-column 48)
  (message "Indent Style: %d %s" arg
	   (if (zerop c-brace-offset) "GNU" "BSD"))
  (local-unset-key "\C-?")
  (local-unset-key "\M-q")
)

(defun c++-mode-hook (&optional arg)
  "Right various Wrongs."
  (interactive "P")
  (or arg (setq arg default-c-indent))
  (c-mode-hook arg)			; do c stuff first
  (setq c++-tab-always-indent c-tab-always-indent)
  (setq c++-class-member-indent c-indent-level)
  (setq c++-friend-offset (- default-c-indent))
  (setq c++-access-specifier-offset c-label-offset)
  )

(defun c-function-at-point (fwd)
  (interactive "P")
;;;;  (debug)
  (condition-case ()
      (save-excursion
	(if fwd (search-forward "("))
	(backward-up-list 1)
	(backward-sexp 1)
	(read (current-buffer)))
    (error nil)))

(defun describe-c-function (function)
  "Display the full documentation of a C FUNCTION (or any manual entry)."
  (interactive 
   (let ((v (c-function-at-point current-prefix-arg))
	 (enable-recursive-minibuffers t)
	 val)
     (list
      (read-string
       (if v (format "Describe C function (default %s): " v)
	 "Describe C function: ")
       (format "%s" v)))))
  (manual function))
