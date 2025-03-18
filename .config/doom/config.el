;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "-k"
      user-mail-address "slowdive@me.com"
      auto-save-default t
      display-line-numbers-type t
      org-directory "~/org/"
      confirm-kill-emacs nil
      projectile-project-search-path '(("~/src" . 1))
      kill-whole-line t
;;;   default-directory "~/src/dotfiles"
      doom-theme 'doom-tomorrow-night
      +doom-dashboard-menu-sections
      (cl-subseq +doom-dashboard-menu-sections 0 3))

(global-set-key (kbd "C-c c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-c v") #'clipboard-yank)

;;; (add-hook 'window-setup-hook #'treemacs 'append)

(setq-hook! 'LaTeX-mode-hook +spellcheck-immediately nil)

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
