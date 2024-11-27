;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;(setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq confirm-kill-emacs nil)
(setq default-directory (concat (getenv "HOME") "/" "src/dotfiles"))
(setq projectile-project-search-path '(("~/src" . 1)))

(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 3))

(global-set-key (kbd "C-c c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-c v") #'clipboard-yank)

;;(add-hook 'window-setup-hook #'treemacs 'append)
