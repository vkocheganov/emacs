;;;;;;;;;; Add additional package sources  ;;;;;;;;;;
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;;;;;;;;; To enable emacs-client programm for committing ;;;;;;;;;;
(require 'server)
(unless (server-running-p) (server-start))

;;;;;;;;;; Make things faster (basics from https://sites.google.com/site/steveyegge2/effective-emacs) ;;;;;;;;;;
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;;;;;;;;; Whitespaces instead of TABS. Always ;;;;;;;;;;
(setq-default indent-tabs-mode nil)

;;;;;;;;;; Themes ;;;;;;;;;;
;;(load-theme 'northcode)
(load-theme 'tango-dark)

;;;;;;;;;; Commands to deal with registers ;;;;;;;;;;
;; Use C-x r i to insert from register
;; Use C-x r s r to insert to register
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)

;;;;;;;;;; Commands to switch windows in the same frame   ;;;;;;;;;;
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

;;;;;;;;;; For proper processing of shell colors ;;;;;;;;;;
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;;;;;;;;; Unset useless "compose mail" key ;;;;;;;;;;
;;;;;;;;;; Set it to be keys for magit usage
(global-unset-key "\C-xm")
(global-set-key (kbd "\C-xms") 'magit-status)

;;;;;;;;;; Make 'up' and 'down' keyboard keys do scrolling (instead of moving) ;;;;;;;;;;
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(global-set-key [(down)] 'gcm-scroll-down)
(global-set-key [(up)]   'gcm-scroll-up)

;;;;;;;;;; Define function to creage GTAGS files ;;;;;;;;;;
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "gtags %s" (directory-file-name dir-name)))
  )

;;;;;;;;;; Save sessions history to ~/.emacs.d/savehist file ;;;;;;;;;;
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring compile-history log-edit-comment-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)

;;;;;;;;;; Python settings ;;;;;;;;;;
(setq python-command "/usr/bin/python3.4")
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

;;;;;;;;;; C++ IDE setup. Guide: https://tuhdo.github.io/c-ide.html ;;;;;;;;;;
;;;;;;;;;; Helm guide: https://tuhdo.github.io/helm-intro.html ;;;;;;;;;;
;;;;;;;;;; Download helm-gtags: https://github.com/syohex/emacs-helm-gtags 
(require 'helm-gtags)
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


(package-initialize)  ;; Important line for helm-gtags to be found. It initializes some installed packages (which cannot be initialized with their default auto-(require 'helm-gtags)
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

;;;;;;;;;; Enable helm-gtags-mode ;;;;;;;;;;
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
(define-key helm-gtags-mode-map (kbd "C-c C-s") 'sr-speedbar-toggle)
(global-set-key "\C-c\C-s" 'sr-speedbar-toggle)

;;;;;;;;;; Speedbar customization ;;;;;;;;;;
(setq speedbar-show-unknown-files t)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)

;;;;;;;;;; Lua customization ;;;;;;;;;;
(defun my-lua-mode-hook ()
  (setq lua-indent-level 4)
  )
(add-hook 'lua-mode-hook 'my-lua-mode-hook)

;;;;;;;;;; Define usefull command ;;;;;;;;;;
(defun copy-file-name ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

;;;;;;;;;; Write backups to ~/.emacs.d/backup/ ;;;;;;;;;; 
(setq backup-directory-alist '(("." . "/home/vkocheganov/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (xcscope use-package reverse-im python neotree mini-header-line markdown-mode magit luarocks lua-mode helm-gtags flymd eimp csv-mode clang-format auto-complete-nxml auto-complete-exuberant-ctags auto-complete-c-headers anaconda-mode ac-c-headers))))
(put 'narrow-to-region 'disabled nil)




;;;;;;;;;; In case I'm on work machine, use https instead of http ;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Aux ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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

