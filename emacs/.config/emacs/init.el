;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(setq-default truncate-lines t)
(setq warning-minimum-level :error)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :font "CaskaydiaCove NFM")
(setq display-line-numbers 'relative)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  :config
  (evil-mode 1))
  ;;(define-key evil-insert-state-map "jk" 'evil-normal-state))
(use-package doom-themes
  :config
  (load-theme 'doom-ir-black t))
(use-package all-the-icons) ;; Run all-the-icons-install-fonts first time
(use-package swiper)
(use-package ivy
  :diminish
  :bind
  (("C-s" . swiper)
   :map ivy-minibuffer-map
   ("TAB" . ivy-alt-done)
   ("C-l" . ivy-alt-done)
   ("C-j" . ivy-next-line)
   ("C-k" . ivy-previous-line)
   :map ivy-switch-buffer-map
   ("C-k" . ivy-previous-line)
   ("C-l" . ivy-done)
   ("C-d" . ivy-switch-buffer-kill)
   :map ivy-reverse-i-search-map
   ("C-k" . ivy-previous-line)
   ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	("C-x b" . counsel-ibuffer)
	("C-x C-f" . counsel-find-file)
	:map minibuffer-local-map
	("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))
(use-package ivy-rich
  :init (ivy-rich-mode 1))
(use-package doom-modeline
  :init (doom-modeline-mode 1))
(use-package writeroom-mode
  :bind ("C-c C-z" . writeroom-mode))
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))
(use-package tldr
  :bind ("C-c C-t" . tldr))
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev/projects")
    (setq projectile-project-search-path '("~/dev/projects")))
  (setq projectile-switch-project-action #'projectile-dired))
(use-package counsel-projectile
  :config (counsel-projectile-mode))
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))
(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))
;; Still evaluating this package
;; (use-package evil-snipe
;;   :init
;;   (evil-snipe-override-mode +1)
;;   :config
;;   (setq evil-snipe-scope 'whole-visible)
;;   :hook (magit-mode . turn-off-evil-snipe-override-mode)) 
(use-package org
  :config
  (setq org-agenda-files '("~/notes/org/tasks.org")))
(use-package avy
  :bind ("C-'" . avy-goto-char-2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))
(use-package lsp-treemacs
  :after lsp)
(use-package lsp-ivy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybinds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package general
  :config
  (general-create-definer sdi/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (sdi/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")
   "tl" '(tldr :which-key "tldr")
   "z" '(writeroom-mode :which-key "toggle zen mode")
   "b" '(:ignore t :which-key "buffer")
   "bp" '(evil-prev-buffer :which-key "prev")
   "bn" '(evil-next-buffer :which-key "next")
   "f" '(:ignore t :which-key "find")
   "ff" '(find-file :which-key "file")
   "w" '(:ignore t :which-key "window")
   "wl" '(evil-window-right :which-key "right")
   "wj" '(evil-window-down :which-key "down")
   "wk" '(evil-window-up :which-key "up")
   "wh" '(evil-window-left :which-key "left")
   "wv" '(evil-window-vsplit :which-key "split vertical")
   "wn" '(evil-window-split :which-key "split horizontal")
   "p" '(projectile-command-map :which-key "projectile")
   "l" '(lsp-command-map :which-key "lsp")
   ))
