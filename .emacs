;; Disable startup-screen
;(setq inhibit-startup-screen 1)
;; Whitespaces instead of TABS. Always
(setq-default indent-tabs-mode nil)
;; Show column number (along with line number)
(column-number-mode 1)
;;(global-set-key "\C-s\C-n" `neotree-toggle)

;;(global-set-key "\C-s\C-k" `kill-whole-line)
;; Commands to deal with registers.
;; Use C-x r i to insert from register
;; Use C-x r s r to insert to register
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)
;; Commands to switch windows in the same frame
(global-set-key "\C-cb" 'windmove-left) 
(global-set-key "\C-cf" 'windmove-right)
(global-set-key "\C-cp" 'windmove-up) 
(global-set-key "\C-cn" 'windmove-down)
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
;; For proper processing of colors.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-unset-key "\C-xm")
(global-set-key (kbd "\C-xms") 'magit-status)
;; To enable emacs-client programm for committing
(server-start)

;; Define and add my hook for c-mode
(defun my-c-mode-common-hook ()
  (c-set-style "Stroustrup")
  ;; Show lines
  (linum-mode 1)
  ;; Following command affects to c-toggle-auto-newline                                                    ;; Automatically indent e.g.
  (c-toggle-electric-state 1)
  ;; Enable autocomplition mode
;  (auto-complete-mode 1)
  ;; Indent size
  (setq c-basic-offset 4)
  ;; Do not insert new line after ';' or ','
  (setq c-hanging-semi&comma-criteria nil)
  (setq comment-start "//"  comment-end   "")
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
                         
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("41576d31aa4aba50b68c66bc186c4a756241e0745ad4d7ff0e25ecbc21642c0b" "1e90834a232ff3b63c41b00e484754293a5c38d73080ddc6f77db72feb0b2f98" "a317b11ec40485bf2d2046d2936946e38a5a7440f051f3fcc4cdda27bde6c5d4" "abc06e7e22663af3fced7ee081f00e4db215b164379657f4ce93d801174eb0a6" "f8c944102219d62deea2379b1a41fc42a215cb3ee78f84841d93fa439930774d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'tango-dark)

(require 'helm-config)
(require 'xcscope)

;; (define-key global-map [\M-.] 'cscope-find-global-definition)
;; (global-set-key "\M-." `cscope-find-global-definition)
(global-set-key [f3]  `cscope-set-initial-directory)
(global-set-key [f4]  `cscope-unset-initial-directory)
(global-set-key [f5]  `cscope-find-this-symbol)
(global-set-key [f6]  `cscope-find-global-definition)
(global-set-key [f7]  'cscope-find-global-definition-no-prompting)
(global-set-key [f8]  `cscope-pop-mark)
(global-set-key [f9]  `cscope-history-forward-line)
(global-set-key [f10]  `cscope-history-forward-file)
(global-set-key [f11]  `cscope-history-backward-line)
(global-set-key [f12]  `cscope-history-backward-file)
;; (global-set-key [escape-f10]  `cscope-display-buffer)
;; (global-set-key (kbd "\M-<f10>")  `cscope-display-buffer)
;; (global-set-key "\M-f10"  `cscope-display-buffer-toggle)

(defun gcm-scroll-up ()
  (interactive)
  (scroll-down 1))
(defun gcm-scroll-down ()
  (interactive)
  (scroll-up 1))

(global-set-key [(down)] 'gcm-scroll-down)
(global-set-key [(up)]   'gcm-scroll-up)


(require 'protobuf-mode)
