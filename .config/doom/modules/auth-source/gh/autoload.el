;;; auth-source/gh/autoload.el -*- lexical-binding: t; -*-

;; major kudos to @MartinNowak on GitHub for providing the foundation here:
;; https://github.com/magit/forge/discussions/544#discussion-4897579
;; =============================================================================
;; use op and gh as auth-source for forge to workaround forbidden PAT access
;; organization
;; -----------------------------------------------------------------------------

;;;###autoload
(cl-defun auth-source-gh-search (&rest spec
                                       &key backend type host user
                                       &allow-other-keys)
  "Given a property list SPEC, return search matches from the `:backend'.
See `auth-source-search' for details on SPEC."
  ;; just in case, check that the type is correct (null or same as the backend)
  (cl-assert (eq type (oref backend type))
             t "Invalid gh search: %s %s")

  (when-let* ((hostname (string-remove-prefix "api." host))
              ;; split ghub--ident again
              (ghub_ident (split-string (or user "") "\\^"))
              (username (car ghub_ident))
              (package (cadr ghub_ident))
              (cmd (format "op plugin run -- gh auth token --hostname '%s'" hostname))
              (token (when (string= package "forge") (string-trim-right (shell-command-to-string cmd))))
              (retval (list
                       :host hostname
                       :user username
                       :secret token)))
    (auth-source-do-debug  "auth-source-gh: return %s as final result (plus hidden password)"
                           (seq-subseq retval 0 -2)) ;; remove password
    (list retval)))

;;;###autoload
(defun auth-source-backends-parser-gh (entry)
  "Create a gh auth-source backend from ENTRY."
  (when (eq entry 'gh)
    (auth-source-backend
     :source "." ;; not used
     :type 'gh
     :search-function #'auth-source-gh-search)))
