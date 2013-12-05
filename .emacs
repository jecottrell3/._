;23-(setq keyboard-translation-table nil)
;23-;;;; $Id$
;23-;;;;(set-input-mode nil t)
;23-;;;;(set-input-mode  t  t)

;23-(setq debug-on-error t)
;23-(setq inhibit-startup-message t)

;23-(load
 ;23-(cond
  ;23-((string-match "^24[.0-9]+$" emacs-version) "~/emacs/emacs-24")
  ;23-((string-match "^23[.0-9]+$" emacs-version) "~/emacs/emacs-23")
  ;23-((string-match "^22[.0-9]+$" emacs-version) "~/emacs/emacs-22")
  ;23-((string-match "^21[.0-9]+$" emacs-version) "~/emacs/emacs-21")
  ;23-((string-match "^20[.0-9]+$" emacs-version) "~/emacs/emacs-20")
  ;23-((string-match "^19[.0-9]+$" emacs-version) "~/emacs/emacs-19")
  ;23-(t                                          "~/emacs/emacs-18")))

;23-(setq debug-on-error nil)
;23-(put 'eval-expression 	'disabled nil)
;23-(put 'narrow-to-region	'disabled nil)
;23-(put 'narrow-to-page	'disabled nil)
