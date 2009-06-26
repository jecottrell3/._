(setq ehelp-map "See HELP-MAP for details.")

(require 'ehelp)

(defun electric-help-retain ()
  "Exit `electric-help', retaining the current window/buffer configuration.
\(The *Help* buffer will not be selected, but \\[switch-to-buffer-other-window] RET
will select it.)"
  (interactive)
  (other-window 1)
  (throw 'exit '(retain)))


(define-key electric-help-map "\C-]" 'other-window)
(define-key electric-help-map "\C-t" 'isearch-forward)
(define-key electric-help-map "\C-r" 'isearch-backward)

(substitute-key-definition 'describe-key
			   'electric-describe-key help-map)
(substitute-key-definition 'describe-mode
			   'electric-describe-mode help-map)
(substitute-key-definition 'view-lossage
			   'electric-view-lossage help-map)
(substitute-key-definition 'describe-function
			   'electric-describe-function help-map)
(substitute-key-definition 'describe-variable
			   'electric-describe-variable help-map)
(substitute-key-definition 'describe-bindings
			   'electric-describe-bindings help-map)
(substitute-key-definition 'describe-syntax
			   'electric-describe-syntax help-map)
