;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(global-set-key (kbd "C-c c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-c v") #'clipboard-yank)
