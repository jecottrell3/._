(defun Info-mode-hook ()
  "Info Mode Hook."
;;;;  (define-key Info-mode-map "\r" 'forward-to-indentation)
;;;;  (define-key Info-mode-map "\t" 'backward-to-indentation)
;;;;  (define-key Info-mode-map "/"  'isearch-forward)
;;;;  (define-key Info-mode-map "\\"  'isearch-backward)
;;;;  (define-key Info-mode-map "o"  'other-window)
;;;;  (define-key Info-mode-map "b"  'end-of-buffer)
;;;;  (define-key Info-mode-map "t"  'beginning-of-buffer)
;;;;  (define-key Info-mode-map "="  'what-cursor-position)
;;;;  (setq Info-mode-hook nil)
)

(defun Info-scroll-up ()
  "Read the next screen.  If end of buffer is visible, go to next entry."
  (interactive)
  (if (pos-visible-in-window-p (point-max))
      (Info-forward-node)		;was Info-next-preorder
      (scroll-up))
  )

(defun Info-scroll-down ()
  "Read the previous screen.  If start of buffer is visible, go to last entry."
  (interactive)
  (if (pos-visible-in-window-p (point-min))
      (Info-backward-node)
      (scroll-down))
  )
