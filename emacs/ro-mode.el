(or (assq 'ro-mode minor-mode-alist)
    (setq minor-mode-alist
	  (cons '(ro-mode " RO") minor-mode-alist)))

(defvar ro-mode nil "*This buffer is read-only.")
(make-variable-buffer-local 'ro-mode)

(defvar ro-map nil "*Keymap to use in read-only buffers")
(if ro-map
    ()
  (setq ro-map (make-sparse-keymap))
  (define-key ro-map "\C-?" 'scroll-down)
  (define-key ro-map "b" 'scroll-down)
  (define-key ro-map "n" 'scroll-up)
  (define-key ro-map " " 'scroll-up)
  (define-key ro-map "\r" 'next-line)
  (define-key ro-map "\t" 'previous-line))

(defun ro-mode (arg)
  "A simpler view-mode."
  (interactive "P")
  (setq ro-mode
	(if arg (< 0 (prefix-numeric-value arg))
	  (not ro-mode)))
  (make-local-variable 'buffer-local-map)
  (make-local-variable 'buffer-local-mode)
  (if (setq buffer-read-only ro-mode)
      (setq buffer-local-map (current-local-map)
;;;;	    buffer-local-mode (cons major-mode mode-name)
;;;;	    major-mode 'ro-mode mode-name "Read-Only"
	    )
;;;;    (setq major-mode (car buffer-local-mode)
;;;;	  mode-name  (cdr buffer-local-mode))
    )
  (use-local-map (if ro-mode ro-map buffer-local-map))
  (set-buffer-modified-p (buffer-modified-p)))
