(defun isearch-mode-hook ()
  "Swap C-s and C-t."
  (interactive)
  (define-key isearch-mode-map "\C-e" 'isearch-edit-string)
  (define-key isearch-mode-map "\C-t" 'isearch-repeat-forward)
  (define-key isearch-mode-map "\C-s" 'isearch-toggle-regexp)
  (define-key minibuffer-local-isearch-map "\C-t"
    'isearch-forward-exit-minibuffer)
  (setq isearch-mode-hook nil))

