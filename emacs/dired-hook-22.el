(defun dired-mode-hook ()
  "Define dired extensions"
  (tick)
  (setq case-fold-search t)
  (define-key dired-mode-map "\t" 'dired-previous-line)
  (define-key dired-mode-map "\r" 'dired-next-line)
  (define-key dired-mode-map "\n" 'dired-next-line)
;;;;  (define-key dired-mode-map "j" 'dired-find-file)
;;;;  (define-key dired-mode-map "k" 'dired-undisplay)
;;;;  (define-key dired-mode-map "K" 'dired-kill-line)
;;;;  (define-key dired-mode-map "l" 'dired-redisplay-file)
;;;;  (define-key dired-mode-map "L" 'dired-load)
;;;;  (define-key dired-mode-map "m" 'dired-make-directory)
;;;;  (define-key dired-mode-map "R" 'dired-rmail)
;;;;  (define-key dired-mode-map "R" 'dired-rmail)
;;;;  (define-key dired-mode-map "V" 'dired-vmail)
;;;;; (define-key dired-mode-map "S" 'dired-symlink)
;;;;  (define-key dired-mode-map "S" 'dired-strip)
;;;;  (define-key dired-mode-map "s" 'dired-sort-by-size)
;;;;  (define-key dired-mode-map "t" 'dired-sort-by-time)
;;;;  (define-key dired-mode-map "Z" 'dired-zap)
;;;;  (setq dired-mode-hook nil)
)

(defun dired-load-hook ()
  "Redefine dired-compress-file to force COMPRESS instead of GZIP."
  (setq dired-load-hook nil)
)

(load-library "dired-aux")

(defun dired-compress-file (file)
  ;; Compress or uncompress FILE.
  ;; Return the name of the compressed or uncompressed file.
  ;; Return nil if no change in files.
  (let ((handler (find-file-name-handler file)))
    (cond (handler
	   (funcall handler 'dired-compress-file file))
	  ((file-symlink-p file)
	   nil)
	  ((let (case-fold-search)
	     (string-match "\\.Z$" file))
	   (if (not (dired-check-process (concat "Uncompressing " file)
					 "uncompress" file))
	       (substring file 0 -2)))
	  ((let (case-fold-search)
	     (string-match "\\.gz$" file))
	   (if (not (dired-check-process (concat "Uncompressing " file)
					 "gunzip" file))
	       (substring file 0 -3)))
	  ;; For .z, try gunzip.  It might be an old gzip file,
	  ;; or it might be from compact? pack? (which?) but gunzip handles
	  ;; both.
	  ((let (case-fold-search)
	     (string-match "\\.z$" file))
	   (if (not (dired-check-process (concat "Uncompressing " file)
					 "gunzip" file))
	       (substring file 0 -2)))
	  (t
	   ;;; Try gzip; if we don't have that, use compress.
	   (condition-case nil
	      	      (if (not (dired-check-process (concat "Compressing " file)
					    "compress" "-f" file))
		  (concat file ".Z"))

	     (file-error
	      (if (not (dired-check-process (concat "Compressing " file)
					    "compress" "-f" file))
		  (concat file ".Z"))
	      ))))))


;;;;;;;;;;;;;;;; EVERYTHING BELOW IS V18 STUFF ;;;;;;;;;;;;;;;;

;;;;(defun dired-undisplay (regexp)		; k
;;;;  "Undisplay files that match REGEXP."
;;;;  (interactive "sUndisplay REGEXP: ")
;;;;  (save-excursion
;;;;    (let ((buffer-read-only nil))
;;;;      (goto-char 0)
;;;;      (flush-lines regexp))))

;;;;(defun dired-kill-line (arg)		; K
;;;;  "Remove ARG lines from display."
;;;;  (interactive "p")
;;;;  (let ((buffer-read-only nil))
;;;;    (forward-line 0)
;;;;    (kill-line arg))
;;;;    (dired-move-to-filename))

;;;;(defun dired-redisplay-file ()		; l
;;;;  "Redisplay this file."
;;;;  (interactive)
;;;;  (let ((buffer-read-only nil))
;;;;    (dired-redisplay (dired-get-filename))))

;;;;(defun dired-load ()			; L
;;;;  "Load this file."
;;;;  (interactive)
;;;;  (let ((buffer-read-only nil))
;;;;    (load-file (dired-get-filename))))

;;;;(defun dired-link (to-file)		; L (old nbs)
;;;;  "Link this file to TO-FILE."
;;;;  (interactive "FLink to: ")
;;;;  (let ((buffer-read-only nil) (from-file (dired-get-filename)))
;;;;    (add-name-to-file from-file to-file)
;;;;    (setq to-file (expand-file-name to-file))
;;;;    (dired-redisplay from-file))
;;;;  (dired-add-entry (file-name-directory to-file)
;;;;		   (file-name-nondirectory to-file)))

;;;;(defun dired-make-directory (to-file)	; m
;;;;  "Make directory TO-FILE."
;;;;  (interactive "FMake directory: ")
;;;;  (setq to-file (expand-file-name to-file))
;;;;  (call-process "/bin/mkdir" nil t nil to-file)
;;;;  (dired-add-entry (file-name-directory to-file)
;;;;		   (file-name-nondirectory to-file)))

;;;;(defun dired-rmail ()			; R
;;;;  "Run `rmail' on this file"
;;;;  (interactive)
;;;;  (let ((buffer-read-only nil)
;;;;        (buffer (current-buffer))
;;;;	(file (dired-get-filename)))
;;;;    (rmail file)
;;;;    (recursive-edit)
;;;;    (switch-to-buffer buffer)
;;;;    (dired-redisplay file)))

;;;;(defun dired-vmail ()			; R
;;;;  "Run `VM' on this file"
;;;;  (interactive)
;;;;  (let ((buffer-read-only nil)
;;;;        (buffer (current-buffer))
;;;;	(file (dired-get-filename)))
;;;;    (vm-visit-folder file)
;;;;    (recursive-edit)
;;;;    (switch-to-buffer buffer)
;;;;    (dired-redisplay file)))

;;;;(defun dired-symlink (to-file)		; S (old nbs)
;;;;  "Symbolic Link this file to TO-FILE."
;;;;  (interactive "FSymlink to: ")
;;;;  (let ((buffer-read-only nil)
;;;;	(from-file (dired-get-filename))
;;;;	(to-dir (expand-file-name (file-name-directory to-file)))
;;;;	(to-name (file-name-nondirectory to-file)))
;;;;    (make-symbolic-link from-file to-file)
;;;;    (if (string-equal to-dir default-directory)
;;;;	(progn
;;;;	  (dired-add-entry to-dir to-name)
;;;;	  (dired-move-to-filename)
;;;;	  (kill-line)
;;;;	  (insert to-name)))))

;;;;(defun dired-strip ()			; S
;;;;  "Strip this file."
;;;;  (interactive)
;;;;  (let* ((buffer-read-only nil)
;;;;	 (from-file (dired-get-filename)))
;;;;    (message "Stripping %s..." from-file)
;;;;    (call-process "strip" nil nil nil from-file)
;;;;    (message "Stripping %s... done" from-file)
;;;;    (dired-redisplay from-file)))

;;;;(defun dired-sort-by-size (arg)		; s
;;;;  "Reread directory, sorting by size."
;;;;  (interactive "P")
;;;;  (let ((opoint (point))
;;;;	(ofile (dired-get-filename t t))
;;;;	(buffer-read-only nil))
;;;;;;;;    (dired-revert)
;;;;    (sort-numeric-fields
;;;;     (if arg -5 5)
;;;;     (progn (goto-char 0) (forward-line 1) (point))
;;;;     (point-max))
;;;;    (or (and ofile (re-search-forward
;;;;		    (concat " " (regexp-quote ofile) "$")
;;;;		    nil t))
;;;;	(goto-char opoint)))
;;;;    (dired-move-to-filename))

;;;;(defun dired-sort-by-time (arg)		; t
;;;;  "Reread directory and sort by time"
;;;;  (interactive "P")
;;;;  (let ((dired-listing-switches
;;;;	 (concat dired-listing-switches (if arg "tr" "t"))))
;;;;    (revert-buffer))
;;;;  (dired-move-to-filename))

;;;;(defun dired-zap ()		; Z
;;;;  "Remove uninteresting files from listing."
;;;;  (interactive)
;;;;  (dired-undisplay "\\.o$")
;;;;  (dired-undisplay "\\.elc$")
;;;;  (dired-undisplay "~$"))

;;;;;;;; Redone to allow directorys as destinations

;;;;(defun dired-rename-file (to-file)
;;;;  "Rename this file to TO-FILE."
;;;;  (interactive "FRename to: ")
;;;;;;;;  (interactive
;;;;;;;;   (list (read-file-name (format "Rename %s to: "
;;;;;;;;				 (file-name-nondirectory (dired-get-filename)))
;;;;;;;;			 nil (dired-get-filename))))
;;;;  (setq to-file (expand-file-name to-file))
;;;;  (and (file-directory-p to-file)
;;;;       (setq to-file
;;;;	     (concat (file-name-as-directory to-file)
;;;;		     (file-name-nondirectory
;;;;		      (dired-get-filename)))))
;;;;  (rename-file (dired-get-filename) to-file 0)
;;;;  (let ((buffer-read-only nil))
;;;;    (beginning-of-line)
;;;;    (delete-region (point) (progn (forward-line 1) (point)))
;;;;    (setq to-file (expand-file-name to-file))
;;;;    (dired-add-entry (file-name-directory to-file)
;;;;		     (file-name-nondirectory to-file))))

;;;;(defun dired-copy-file (to-file)
;;;;  "Copy this file to TO-FILE."
;;;;  (interactive "FCopy to: ")
;;;;  (setq to-file (expand-file-name to-file))
;;;;  (and (file-directory-p to-file)
;;;;       (setq to-file
;;;;	     (concat (file-name-as-directory to-file)
;;;;		     (file-name-nondirectory
;;;;		      (dired-get-filename)))))
;;;;  (copy-file (dired-get-filename) to-file 0)
;;;;;;;;  (setq to-file (expand-file-name to-file))
;;;;  (dired-add-entry (file-name-directory to-file)
;;;;		   (file-name-nondirectory to-file)))
