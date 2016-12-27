;;; init.el --- Sets up emacs environment
;;; Commentary:

;;; Code:

;; Custom commands
(defun copy-whole-buffer ()
  "Copy entire buffer to clipboard."
  (interactive)
  (clipboard-kill-ring-save (point-min) (point-max)))

;; Bootstrap `use-package'

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))


;; Emacs configuration

(setq inhibit-startup-message t)
(setq initial-scratch-message ";; Take notes here. <SPACE> e will edit a new file\n\n")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq ediff-split-window-function 'split-window-horizontally)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(tool-bar-mode -1)
(savehist-mode 1)

(use-package company
  :ensure t)

(use-package eldoc
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.2)
  (setq key-chord-one-key-delay 0.3))

(use-package magit
  :ensure t)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Appearance

(use-package powerline
  :ensure t
  :config
  (powerline-center-evil-theme)

 (use-package flycheck-color-mode-line
    :ensure t
    :config
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
)

(use-package leuven-theme
  :ensure t)


;; Evil mode

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-escape
    :ensure t
    :config
    (evil-escape-mode 1)
    (setq-default evil-escape-key-sequence "fd")
    (setq-default evil-escape-delay 0.2))

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "e" 'find-file
      "bb" 'switch-to-buffer
      "bd" 'kill-buffer-and-window
      "by" 'copy-whole-buffer
      "cy" 'clipboard-kill-ring-save
      "cp" 'clipboard-yank
      "fs" 'save-buffer
      "gs" 'magit-status
      "hs" 'split-window-horizontally
      "iu" 'insert-char
      "lf" 'load-file
      "ne" 'flycheck-next-error
      "pe" 'flycheck-previous-error
      "rm" 'notmuch
      "sm" 'message-send-and-exit
      "si" 'whitespace-mode
      "tn" 'linum-mode
      "w1" 'delete-other-windows
      "wk" 'windmove-left
      "wj" 'windmove-right
      "qq" 'save-buffers-kill-emacs
      "zp" 'zeal-at-point
      )
    )

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))

;; Notmuch

(setq user-mail-address "garryjcairns@gmail.com"
      user-full-name "Garry Cairns")
(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 25)
(setq send-mail-function 'smtpmail-send-it)
(setq notmuch-hello-sections '(notmuch-hello-insert-header notmuch-hello-insert-alltags))
(evil-add-hjkl-bindings notmuch-search-mode-map 'emacs)
(evil-add-hjkl-bindings notmuch-show-mode-map 'emacs)
(evil-set-initial-state 'notmuch-search-mode 'emacs)
(evil-set-initial-state 'notmuch-show-mode 'emacs)

;; Org mode

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;; Programming and writing environments

(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  (setq elpy-rpc-python-command "python3")
  (setq elpy-rpc-backend "jedi")
  (elpy-use-cpython "/usr/bin/python3")
  (setq python-check-command "~/.local/bin/pyflakes")
  (add-hook 'python-mode-hook (lambda () (show-paren-mode 1))))

(use-package haskell-mode
  :ensure t)

(use-package intero
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

(use-package markdown-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

;; Zeal setup

(use-package zeal-at-point
  :ensure t)

(add-to-list 'zeal-at-point-mode-alist '(haskell-mode . "haskell"))
(add-to-list 'zeal-at-point-mode-alist '(python-mode . "python"))

(provide 'init)
;;; init.el ends here
