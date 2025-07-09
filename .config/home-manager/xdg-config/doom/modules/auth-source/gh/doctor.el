;;; auth-source/gh/doctor.el -*- lexical-binding: t; -*-

(unless (executable-find "gh")
  (error! "`gh' is not in your PATH. auth-source-gh will not function. To install, run `brew install gh' or download from https://cli.github.com."))

(when (executable-find "gh")
  (let ((auth-status (shell-command-to-string "op plugin run -- gh auth status")))
    (unless (string-match-p "Logged in to github.com" auth-status)
      (error! "Not logged in to GitHub"))))
