(setq keyboard-translation-table nil)
;;;;(set-input-mode nil t)
;;;;(set-input-mode  t  t)

(setq debug-on-error t)
(setq inhibit-startup-message t)

(load
 (cond
  ((string-match "^21[.0-9]+$" emacs-version) "~/emacs/emacs-21")
  ((string-match "^20[.0-9]+$" emacs-version) "~/emacs/emacs-20")
  ((string-match "^19[.0-9]+$" emacs-version) "~/emacs/emacs-19")
  (t                                          "~/emacs/emacs-18")))

(setq debug-on-error nil)
(put 'eval-expression 	'disabled nil)
(put 'narrow-to-region	'disabled nil)
(put 'narrow-to-page	'disabled nil)
