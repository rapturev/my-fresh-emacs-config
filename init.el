(keymap-global-set "C-c p p" 'package-list-packages)
(keymap-global-set "C-c p r" 'package-refresh-contents)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room


(menu-bar-mode -1)    

(set-face-attribute 'default nil :font "Cascadia Code" :height 125)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa-snapshots" . "https://snapshots.melpa.org/packages/")                         
                         ("elpa" . "https://elpa.gnu.org/packages/")))
						 
(setq display-line-numbers-type 'relative)
(column-number-mode)
(global-display-line-numbers-mode t)

(use-package eclipse-theme
 :ensure t)
;; (load-theme 'modus-operandi-tritanopia)
;; (load-theme 'eclipse)

(use-package php-mode
 :ensure t)
 
(use-package go-mode
 :ensure t
 :mode "\\.go\\'")
 
(use-package clojure-mode
 :ensure t
 :mode (("\\.clj\\'" . clojure-mode)
        ("\\.cljs\\'" . clojurescript-mode)
        ("\\.cljc\\'" . clojurec-mode)
        ("\\.edn\\'" . clojure-mode))
 :config)
  
(use-package evil
 :ensure t
 :init
 :config)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(eclipse))
 '(custom-safe-themes
   '("26e644fb119d4f5e4b576bae0e37e949721cb43ca6d234c9318208bad2b77cf6"
     "4c92d278dc295b63daf817d668523d442058d6c90728958dc92b6bc976fffd96"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
