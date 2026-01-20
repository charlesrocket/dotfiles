;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setopt user-full-name "-k"
        user-mail-address "slowdive@me.com"
        auto-save-default t
        display-line-numbers-type t
        org-directory "~/org/"
        confirm-kill-emacs nil
        projectile-project-search-path '(("~/src" . 1))
        kill-whole-line t
        delete-by-moving-to-trash t
;;;     default-directory "~/src/dotfiles"
        frame-title-format "%b (-_-) ╭∩╮"
        gcmh-idle-delay 5
        doom-theme 'doom-tomorrow-night
        doom-modeline-enable-word-count t
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-lsp-icon t
        doom-modeline-major-mode-color-icon t
        +doom-dashboard-menu-sections
        (cl-subseq +doom-dashboard-menu-sections 0 3))

(global-set-key (kbd "C-c c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-c v") #'clipboard-yank)

;;; (add-hook 'window-setup-hook #'treemacs 'append)

(setq-hook! 'LaTeX-mode-hook +spellcheck-immediately nil)

(after! projectile
    (setq projectile-enable-caching t)
    (setq projectile-indexing-method 'hybrid))

(projectile-add-known-project "~/src/dotfiles")
(projectile-add-known-project "~/src/misc-files")

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
    (setopt languagetool-java-arguments '("-Dfile.encoding=UTF-8")
            languagetool-console-command "~/.languagetool/languagetool-commandline.jar"
            languagetool-server-command "~/.languagetool/languagetool-server.jar"))
