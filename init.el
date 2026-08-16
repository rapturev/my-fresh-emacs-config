(keymap-global-set "C-c p p" 'package-list-packages)
(keymap-global-set "C-c p r" 'package-refresh-contents)

(setq-default default-directory "d:/Programming/")

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room


(menu-bar-mode -1)    

(set-face-attribute 'default nil :font "Cascadia Code NF" :height 125)

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")) t)
(package-initialize)
						 
(setq display-line-numbers-type 'relative)
(column-number-mode)
(global-display-line-numbers-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4c92d278dc295b63daf817d668523d442058d6c90728958dc92b6bc976fffd96"
     default))
 '(package-selected-packages
   '(centaur-tabs cider company consult dirvish doom-modeline
		  eclipse-theme evil exec-path-from-shell go-mode helm
		  ligature lsp-ui marginalia mood-line orderless
		  paredit php-mode project projectile
		  rainbow-delimiters spaceline vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centaur-tabs-default ((t (:background "#abb2bf" :foreground "#5c6370"))))
 '(centaur-tabs-selected ((t (:background "#7F0055" :foreground "#abb2bf" :weight bold))))
 '(centaur-tabs-selected-modified ((t (:background "#7F0055" :foreground "#da8548"))))
 '(centaur-tabs-unselected ((t (:background "#abb2bf" :foreground "#5c6370"))))
 '(centaur-tabs-unselected-modified ((t (:background "#7F0055" :foreground "#da8548"))))
 '(mode-line ((t (:foreground "#ffffff" :background "#7F0055" :box nil))))
 '(mode-line-inactive ((t (:foreground "#bcbcbc" :background "#7F0055" :box nil)))))
 
(load-theme 'eclipse)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(use-package centaur-tabs
  :init 
  (setq centaur-tabs-enable-key-bindings t)
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
    (("C-<tab>" . centaur-tabs-forward)
     ("C-S-<tab>" . centaur-tabs-backward)
     ("C-c <left>" . centaur-tabs-backward-group)
     ("C-c <right>" . centaur-tabs-forward-group))
     ("C-x t w" . centaur-tabs--create-new-tab)
     ("C-x t q" . centaur-tabs--kill-this-buffer-dont-ask))
(setq centaur-tabs-style "alternate")
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-bar 'under)
;; Note: If you're not using Spacmeacs, in order for the underline to display
;; correctly you must add the following line:
(setq x-underline-at-descent-line t)
(centaur-tabs-change-fonts "Cascadia Code" 160)





(use-package evil
 :ensure t)
(evil-mode 1)

(electric-pair-mode 1)
(show-paren-mode 1) 



(use-package powerline
  :ensure t
  :config
  (powerline-center-evil-theme))



(use-package php-mode
  :ensure t
  :mode ("\\.php\\'" . php-mode)
  :hook (php-mode-hook . (lambda ()
                           ;; Set indentation spacing (e.g., 4 spaces)
                           (setq c-basic-offset 4)
                           ;; Ensure spaces are used instead of physical tabs
                           (setq indent-tabs-mode nil)
                           ;; Enable subword-mode for navigating CamelCase words easily
                           (subword-mode 1))))


(use-package go-mode
 :ensure t
 :mode "\\.go\\'"
 :hook (go-ts-mode . eglot-ensure))
 
(use-package clojure-mode
 :ensure t
 :mode (("\\.clj\\'" . clojure-mode)
        ("\\.cljs\\'" . clojurescript-mode)
        ("\\.cljc\\'" . clojurec-mode)
        ("\\.edn\\'" . clojure-mode))
 :config)

 (use-package cider
  :ensure t
  :defer t
  :init
  (add-hook 'clojure-mode-hook #'cider-mode)
  :config
  ;; Adjust REPL configurations to your liking
  (setq cider-repl-display-help nil            ; Hide helper text on startup
        cider-repl-pop-to-buffer-on-connect t  ; Focus REPL once it starts
        cider-repl-use-pretty-printing t       ; Pretty print evaluation outputs
        cider-font-lock-dynamically '(macro core function var)))

;; 3. Structural Editing (Crucial for Lisp/Clojure parens)
(use-package paredit
  :ensure t
  :hook ((clojure-mode . paredit-mode)
         (cider-repl-mode . paredit-mode)))

;; 4. Visual Parentheses Color Management
(use-package rainbow-delimiters
  :ensure t
  :hook (clojure-mode . rainbow-delimiters-mode))

;; (use-package lsp-intelephense
;;  :ensure t
;;  :after lsp-mode)

 (use-package lsp-mode
  :ensure t
  :init
  ;; Set the prefix for LSP commands (e.g., C-c l f for formatting)
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; Replace these with the major modes you use
        ;; (python-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (clojure-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         (php-mode . lsp-deferred)
         ;; Toggle integration with which-key if installed
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

;; Optional: Fancy UI additions (doc popups, peek views, sidelines)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-show-hover t))
 
(use-package helm
  :ensure t
  :init
  ;; Change the default helm prefix from "C-x c" to "C-c h" to avoid accidental exits
  (setq helm-command-prefix-key "C-c h")
  :bind (;; Replace standard Emacs completion commands with Helm equivalents
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("C-x r b" . helm-filtered-bookmarks)
         ("M-y" . helm-show-kill-ring)
         :map helm-map
         ;; Make TAB behave like tab completion instead of showing the action menu
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action)
         ;; Bind alternative key to show the action menu
         ("C-z" . helm-select-action))
  :config
  ;; Enable fuzzy matching across major Helm commands
  (setq helm-mode-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t)
  
  ;; UI Behavior Tweaks
  (setq helm-split-window-inside-p t           ; Open Helm inside the current window
        helm-move-to-line-cycle-in-source t    ; Move back to top/bottom when scrolling
        helm-scroll-amount 8                   ; Scroll 8 lines at a time
        helm-ff-search-library-in-path t)      ; Search libraries in load-path

  ;; Activate Helm everywhere completion is used
  (helm-mode 1))

(use-package projectile
  :ensure t
  :init
  ;; Bind the prefix map to both traditional and modern keys
  ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  :config
  ;; Enable Projectile globally
  (projectile-mode +1)
  
  ;; Configure caching for large projects
  (setq projectile-enable-caching t)
  (setq projectile-file-exists-remote-cache-expire nil)
  
  ;; Define where your projects live to auto-discover them
  (setq projectile-project-search-path '("~/Projects" "~/Development"))
  
  ;; Choose what happens when you switch to a project
  ;; Options: 'projectile-find-file (default), 'projectile-dired, 'projectile-vterm
  (setq projectile-switch-project-action #'projectile-dired))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  ;; Settings to make completion feel snappy
  (setq company-idle-delay 0.0              ; Decrease delay to fetch completions instantly
        company-minimum-prefix-length 1     ; Show completions after typing 1 character
        company-selection-wrap-around t)    ; Loop back to top/bottom when scrolling

  ;; Better keyboard navigation inside the popup menu
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

;; Bind it to a shortcut
(global-set-key (kbd "C-c f") 'my/helm-find-files-in-default-dir)

(use-package ligature
  :ensure t
  :config
  ;; Enable all standard programming ligatures for all modes
  (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                               ":::" "::=" "=:=" "===" "==>" "=>" "=>>" "<=" "<== "
                               "&&" "-->" "-->" "-> " "->>" "<->" "<-->" "---" "<~>"
                               "~>" "<~" "~~" "[[" "]]" "::" "++" "+++" "??" "///" "##"
                               "///" "/*" "*/" "::" "!!" ".-" "?:" "?." "?=" "/*" "*/"
                               "&&&" "&&" "||" "|||" "++" "+++" "--" "---" "==" "==="
                               "!=" "!==" "=:=" "=/=" "<=" ">=" "<->" "<-" "->" "-->"
                               "==>" "=>" "<=>" "<==>" "\\\\" "\\\\\\\\" "{-" "-}"
                               "(*" "*)" ":::" "::" ":=" "=+ " "=-" "=+" "+=" "-="
                               "*=" "/=" "%=" "&=" "|=" "^=" "<<=" ">>=" ">>-" "->>"
                               "-<" "-<<" "<-<" "<--" "<~" "<~~" "~>" "~~>" "-->" "=>"
                               "==>" ">->" "->>" "->>>" "<-" "<--" "<<-" "<<<-" "<->"
                               "<-->" "<==>" "<=>" "<~>" "~~>" "-->" "=>" "==>"))
  
  ;; Activate the global minor mode
  (global-ligature-mode 1))

(use-package exec-path-from-shell
   :ensure t
   :config 
   (exec-path-from-shell-initialize))

(use-package project
  :ensure t)

(use-package dirvish
  :ensure t)
(dirvish-override-dired-mode)



