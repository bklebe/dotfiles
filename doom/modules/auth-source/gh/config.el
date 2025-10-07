;;; auth-source/gh/config.el -*- lexical-binding: t; -*-

(after! auth-source
  (add-hook! 'auth-source-backend-parser-functions #'auth-source-backends-parser-gh)
  (pushnew! auth-sources 'gh))
