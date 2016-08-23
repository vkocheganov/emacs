;; Disable startup-screen
;(setq inhibit-startup-screen 1)
;; Whitespaces instead of TABS. Always
(setq-default indent-tabs-mode nil)
;; Show column number (along with line number)
(column-number-mode 1)
;; Disable key to provide bigger variety of bindigs
(global-unset-key "\C-s")

(global-set-key "\C-ss" `isearch-forward)
(global-set-key "\C-cs" `shell)
(global-set-key "\C-sk" `kill-whole-line)
;; Commands to deal with registers.
;; Use C-x r i to insert from register
;; Use C-x r s r to insert to register
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)
;; Commands to switch windows in the same frame
;; (global-set-key "\C-cb" 'windmove-left) 
;; (global-set-key "\C-cf" 'windmove-right)
;; (global-set-key "\C-cp" 'windmove-up) 
;; (global-set-key "\C-cn" 'windmove-down)
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))
;; For proper processing of colors.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; To enable emacs-client programm for committing
(server-start)

;; Define and add my hook for c-mode
(defun my-c-mode-common-hook ()
  (c-set-style "Stroustrup")
  ;; Show lines
  (linum-mode 1)
  ;; Following command affects to c-toggle-auto-newline                                                    ;; Automatically indent e.g.
  (c-toggle-electric-state 1)
  ;; Insert new line after '{' e.g.
  (c-toggle-auto-newline 1)
  ;; Enable autocomplition mode
;  (auto-complete-mode 1)
  ;; Indent size
  (setq c-basic-offset 4)
  ;; Do not insert new line after ';' or ','
  (setq c-hanging-semi&comma-criteria nil)
  (setq comment-start "//"  comment-end   "")
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
;(setq x-select-enable-clipboard t)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
                         
