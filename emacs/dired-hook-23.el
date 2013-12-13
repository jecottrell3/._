;23-(defun dired-mode-hook ()
;23-  "Define dired extensions"
;23-  (tick)
;23-  (setq case-fold-search t)
;23-  (define-key dired-mode-map "\t" 'dired-previous-line)
;23-  (define-key dired-mode-map "\r" 'dired-next-line)
;23-  (define-key dired-mode-map "\n" 'dired-next-line)
;23-;;;;  (define-key dired-mode-map "j" 'dired-find-file)
;23-;;;;  (define-key dired-mode-map "k" 'dired-undisplay)
;23-;;;;  (define-key dired-mode-map "K" 'dired-kill-line)
;23-;;;;  (define-key dired-mode-map "l" 'dired-redisplay-file)
;23-;;;;  (define-key dired-mode-map "L" 'dired-load)
;23-;;;;  (define-key dired-mode-map "m" 'dired-make-directory)
;23-;;;;  (define-key dired-mode-map "R" 'dired-rmail)
;23-;;;;  (define-key dired-mode-map "R" 'dired-rmail)
;23-;;;;  (define-key dired-mode-map "V" 'dired-vmail)
;23-;;;;; (define-key dired-mode-map "S" 'dired-symlink)
;23-;;;;  (define-key dired-mode-map "S" 'dired-strip)
;23-;;;;  (define-key dired-mode-map "s" 'dired-sort-by-size)
;23-;;;;  (define-key dired-mode-map "t" 'dired-sort-by-time)
;23-;;;;  (define-key dired-mode-map "Z" 'dired-zap)
;23-;;;;  (setq dired-mode-hook nil)
;23-)
;23-
;23-(defun dired-load-hook ()
;23-  "Redefine dired-compress-file to force COMPRESS instead of GZIP."
;23-  (setq dired-load-hook nil)
;23-)
;23-
;23-(load-library "dired-aux")
;23-
;23-(defun dired-compress-file (file)
;23-  ;; Compress or uncompress FILE.
;23-  ;; Return the name of the compressed or uncompressed file.
;23-  ;; Return nil if no change in files.
;23-  (let ((handler (find-file-name-handler file)))
;23-    (cond (handler
;23-	   (funcall handler 'dired-compress-file file))
;23-	  ((file-symlink-p file)
;23-	   nil)
;23-	  ((let (case-fold-search)
;23-	     (string-match "\\.Z$" file))
;23-	   (if (not (dired-check-process (concat "Uncompressing " file)
;23-					 "uncompress" file))
;23-	       (substring file 0 -2)))
;23-	  ((let (case-fold-search)
;23-	     (string-match "\\.gz$" file))
;23-	   (if (not (dired-check-process (concat "Uncompressing " file)
;23-					 "gunzip" file))
;23-	       (substring file 0 -3)))
;23-	  ;; For .z, try gunzip.  It might be an old gzip file,
;23-	  ;; or it might be from compact? pack? (which?) but gunzip handles
;23-	  ;; both.
;23-	  ((let (case-fold-search)
;23-	     (string-match "\\.z$" file))
;23-	   (if (not (dired-check-process (concat "Uncompressing " file)
;23-					 "gunzip" file))
;23-	       (substring file 0 -2)))
;23-	  (t
;23-	   ;;; Try gzip; if we don't have that, use compress.
;23-	   (condition-case nil
;23-	      	      (if (not (dired-check-process (concat "Compressing " file)
;23-					    "compress" "-f" file))
;23-		  (concat file ".Z"))
;23-
;23-	     (file-error
;23-	      (if (not (dired-check-process (concat "Compressing " file)
;23-					    "compress" "-f" file))
;23-		  (concat file ".Z"))
;23-	      ))))))
;23-
;23-
;23-;;;;;;;;;;;;;;;; EVERYTHING BELOW IS V18 STUFF ;;;;;;;;;;;;;;;;
;23-
;23-;;;;;;;;;;;;;;;; NUKED -- I cannot remember it ;;;;;;;;;;;;;;;;
