;;;;;;;;;; Remove unnecessary windows ;;;;;;;;;;
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;;;;;;;;; Themes ;;;;;;;;;;
;;(load-theme 'northcode)
(load-theme 'tango-dark)

;;;;;;;;;; Garbage collector bytes threshold ;;;;;;;;;;
(setq gc-cons-threshold 100000000)

;;;;;;;;;; Hide startup screen ;;;;;;;;;;
(setq inhibit-startup-message t)

;;;;;;;;;; Show unncessary whitespace that can mess up your diff ;;;;;;;;;;
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;;;;;;;;;; Whitespaces instead of TABS. Always ;;;;;;;;;;
(setq-default indent-tabs-mode nil)

;;;;;;;;;; Show parenthesis ;;;;;;;;;;
(show-paren-mode t)
;;;;;;;;;; and highlight them ;;;;;;;;;;
;; (setq show-paren-style 'expression)
(electric-indent-mode nil)
(electric-pair-mode t)

;;;;;;;;;; Make things faster (basics from https://sites.google.com/site/steveyegge2/effective-emacs) ;;;;;;;;;;
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

;;;;;;;;;; Commands to deal with registers ;;;;;;;;;;
;; Use C-x r i to insert FROM register
;; Use C-x r s r to insert TO register
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)

;;;;;;;;;; Commands to switch windows in the same frame   ;;;;;;;;;;
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

;;;;;;;;;; Set appearance of a tab that is represented by 4 spaces ;;;;;;;;;;
(setq-default tab-width 4)

;;;;;;;;;; Compilation ;;;;;;;;;;
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;;;;;;;;;; Setup GDB ;;;;;;;;;;
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;;;;;;;;;; Projejctile project management tool ;;;;;;;;;;
(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)


;;;;;;;;;;
;;;;;;;;;; Functions definintions
;;;;;;;;;;

;;;;;;;;;; Make 'up' and 'down' keyboard keys do scrolling (instead of moving) ;;;;;;;;;;
(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))
(global-set-key [(down)] 'gcm-scroll-down)
(global-set-key [(up)]   'gcm-scroll-up)

;;;;;;;;;; Save sessions history to ~/.emacs.d/savehist file ;;;;;;;;;;
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring compile-history log-edit-comment-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)

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

;;; comment only region, not the lines. Makes sense when comment several lines
(setq cd2/region-command 'cd2/comment-or-uncomment-region)

(provide 'setup-general)

(use-package company-shell
  :config
  (push 'company-shell company-backends)
  )

;; (defalias 'yes-or-no-p 'y-or-n-p)

;; ;; Package zygospore
;; (use-package zygospore
;;   :bind (("C-x 1" . zygospore-toggle-delete-other-windows)
;;          ("RET" .   newline-and-indent)))

;; (windmove-default-keybindings)
