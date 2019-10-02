;;;;;;;;;; ************************************************
;;;;;;;;;; ******** General section ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************


;;;;;;;;;; Maximize screen on starup ;;;;;;;;;;
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;;;;;;;; Add additional package sources  ;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;;;;;;;;; In case I'm on work machine, use https instead of http ;;;;;;;;;;
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize) ;; Important line for helm-gtags to be found. It initializes some installed packages (which cannot be initialized with their default auto-(require 'helm-gtags)

;;;;;;;;;; Load updates from these sources. Or 'use-package' will not be available  ;;;;;;;;;;
(when (not package-archive-contents)
  (package-refresh-contents))

;;;;;;;;;; Install 'use-package'  ;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;;;;;;;;;; Make all the packages be loaded with 'use-package' instruction  ;;;;;;;;;;
(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;; To enable emacs-client programm for committing ;;;;;;;;;;
(use-package server)
(unless (server-running-p) (server-start))



;;;;;;;;;; ************************************************
;;;;;;;;;; ******** Python settings ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************

(setq python-command "/usr/bin/python3.4")
(use-package posframe)
(use-package anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(eval-after-load 'python
  '(define-key python-mode-map "\C-xpb" 'python-nav-backward-block))
(eval-after-load 'python
  '(define-key python-mode-map "\C-xpl" 'python-nav-backward-up-list))
(eval-after-load 'python
  '(define-key python-mode-map "\C-xpf" 'python-nav-forward-block))
(eval-after-load 'python
  '(define-key python-mode-map "\C-xpm" 'python-mark-defun))
(eval-after-load 'python
  '(define-key python-mode-map "\C-xpm" 'python-mark-defun))
(eval-after-load 'python
  '(define-key python-mode-map "\M-i" 'anaconda-mode-complete))

;;;;;;;;;; ************************************************
;;;;;;;;;; ******** C++ IDE setup ********* ;;;;;;;;;;
;;;;;;;;;; ******** Guide: https://tuhdo.github.io/c-ide.html ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************

;;;;;;;;;; Define function to create GTAGS files ;;;;;;;;;;
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "gtags %s" (directory-file-name dir-name)))
  )

;;;;;;;;;; Helm guide: https://tuhdo.github.io/helm-intro.html ;;;;;;;;;;
;;;;;;;;;; Download helm-gtags: https://github.com/syohex/emacs-helm-gtags
(defun my-c-mode-common-hook ()
  (c-set-style "Stroustrup")
  ;; Show lines
  (linum-mode 1)
  ;; Following command affects to c-toggle-auto-newline
  ;; That is automatically indent line after inserting
  ;; one of {, }, :, #, ;, ,, <, >, /, *, (, and ).
  (c-toggle-electric-state 1)
  ;; Indent size
  (setq c-basic-offset 4)
  ;; Enable autocomplition mode
  ;; (auto-complete-mode 1)
  ;; Do not insert new line after ';' or ','
  (setq c-hanging-semi&comma-criteria nil)
  (setq comment-start "//"  comment-end   "")
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)



;;;;;;;;;; Speedbar customization ;;;;;;;;;;
(use-package sr-speedbar)
(global-set-key "\C-c\C-s" 'sr-speedbar-toggle)
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)



;;;;;;;;;; ************************************************
;;;;;;;;;; ******** LUA customization  ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************

(defun my-lua-mode-hook ()
  (setq lua-indent-level 4)
  )
(add-hook 'lua-mode-hook 'my-lua-mode-hook)



;;;;;;;;;; ************************************************
;;;;;;;;;; ******** Shell customization  ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************

;;;;;;;;;; For proper processing of shell colors ;;;;;;;;;;
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)



;;;;;;;;;; ************************************************
;;;;;;;;;; ******** Other customization  ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************

;;;;;;;;;; Unset useless "compose mail" key ;;;;;;;;;;
;;;;;;;;;; Set it to be keys for magit usage
(use-package magit)
(global-unset-key "\C-xm")
(global-set-key (kbd "\C-xms") 'magit-status)


(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(require 'setup-helm)
(require 'setup-rtags)
;; (require 'setup-helm-gtags)
;; (if (version< emacs-version "24.4")
;;     (require 'setup-ivy-counsel)
;;   (require 'setup-helm)
;;   (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
;;(require 'setup-ggtags)

;(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-c)


;;;;;;;;;; ************************************************
;;;;;;;;;; ******** AUX  ********* ;;;;;;;;;;
;;;;;;;;;; ************************************************


;;;;;;;;;; Mystery line
;; (put 'dired-find-alternate-file 'disabled nil)

;; (require 'helm-config)
;; (load "~/.emacs.d/lua2-mode.el")



;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(csv-separators (quote ("," "	" ";")))
;;  '(custom-safe-themes
;;    (quote
;;     ("b741b866edeaa1df91a7c0dd8f93108fd94cf54af033b3ae7b19eac783468aba" "41576d31aa4aba50b68c66bc186c4a756241e0745ad4d7ff0e25ecbc21642c0b" "1e90834a232ff3b63c41b00e484754293a5c38d73080ddc6f77db72feb0b2f98" "a317b11ec40485bf2d2046d2936946e38a5a7440f051f3fcc4cdda27bde6c5d4" "abc06e7e22663af3fced7ee081f00e4db215b164379657f4ce93d801174eb0a6" "f8c944102219d62deea2379b1a41fc42a215cb3ee78f84841d93fa439930774d" default)))
;;  '(package-selected-packages
;;    (quote
;;     (lua-mode zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))


;;
;;;;;;;;;; To get colorized output from shell-mode ;;;;;;;;;;
;;
;; (require 'ansi-color)
;; (defun ansi-color-apply-on-buffer ()
;;     (ansi-color-apply-on-region (point-min) (point-max)))
;; (defun ansi-color-apply-on-minibuffer ()
;;   (let ((bufs (remove-if-not
;;                (lambda (x) (string-starts-with (buffer-name x) " *Echo Area"))
;;                (buffer-list))))
;;     (dolist (buf bufs)
;;       (with-current-buffer buf
;;         (ansi-color-apply-on-buffer)))))
;; (defun ansi-color-apply-on-minibuffer-advice (proc &rest rest)
;;   (ansi-color-apply-on-minibuffer))
;; (advice-add 'shell-command :after #'ansi-color-apply-on-minibuffer-advice)
;; (advice-remove 'shell-command #'ansi-color-apply-on-minibuffer-advice)
;; (defun add-test-function (cmd)
;;   (interactive "sCommand to run: ")
;;   (setq my-testall-test-function cmd)
;;   (defun my-testall ()
;;     (interactive)
;;     (shell-command my-testall-test-function))
;;   (local-set-key [f9] 'my-testall))
;; (defun my-shell-execute(cmd)
;;   (interactive "sShell command: ")
;;   (shell (get-buffer-create "my-shell-buf"))
;;   (process-send-string (get-buffer-process "my-shell-buf") (concat cmd "\n")))
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)



;; (load-file '"~/.emacs.d/init.el")


;;;;;;;;;; Disable startup-screen ;;;;;;;;;;
;(setq inhibit-startup-screen 1)

;;;;;;;;;; Show column number (along with line number) ;;;;;;;;;;
;;(column-number-mode 1)

;;;;;;;;;; Enable filebrowser on the left ;;;;;;;;;;
;;(global-set-key "\C-s\C-n" `neotree-toggle)


;; (global-set-key "\C-cb" 'windmove-left)
;; (global-set-key "\C-cf" 'windmove-right)
;; (global-set-key "\C-cp" 'windmove-up)
;; (global-set-key "\C-cn" 'windmove-down)








;; ;;;;;;;;;; Set conscolors in magit on 142 machine ;;;;;;;;;;
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(cursor ((t (:background "gold" :foreground "#151718"))))
;;  '(magit-diff-added ((((type tty)) (:foreground "green"))))
;;  '(magit-diff-added-highlight ((((type tty)) (:foreground "LimeGreen"))))
;;  '(magit-diff-context-highlight ((((type tty)) (:foreground "default"))))
;;  '(magit-diff-file-heading ((((type tty)) nil)))
;;  '(magit-diff-removed ((((type tty)) (:foreground "red"))))
;;  '(magit-diff-removed-highlight ((((type tty)) (:foreground "IndianRed"))))
;;  '(magit-section-highlight ((((type tty)) (:background "dim gray"))))
;;  '(mode-line ((t (:background "black" :foreground "#4499FF"))))
;;  '(neo-dir-link-face ((t (:foreground "deep sky blue" :slant normal :weight bold :height 120 :family "Fantasque Sans Mono"))))
;;  '(neo-file-link-face ((t (:foreground "White" :weight normal :height 120 :family "Fantasque Sans Mono")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(irony-server yasnippet-snippets yasippet-snippets auto-complete-config auto-complete flycheck rtags cmake-ide posframe anaconda-mode anaconda sr-speedbar projectile company use-package magit helm-gtags))
 '(speedbar-show-unknown-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
