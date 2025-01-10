;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "-k"
      user-mail-address "slowdive@me.com")

(setq doom-theme '
      doom-tomorrow-night
      ;;doom-one
)

(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq confirm-kill-emacs nil)
(setq projectile-project-search-path '(("~/src" . 1)))
(setq default-directory "~/src/dotfiles" )
(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 3))

(global-set-key (kbd "C-c c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-c v") #'clipboard-yank)

;;; (add-hook 'window-setup-hook #'treemacs 'append)

(use-package languagetool
  :ensure t
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "~/.languagetool/languagetool-commandline.jar"
        languagetool-server-command "~/.languagetool/languagetool-server.jar"))
