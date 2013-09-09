;; Disable startup-screen
(setq inhibit-startup-screen 1)
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
  (auto-complete-mode 1)
  ;; Indent size
  (setq c-basic-offset 4)
  ;; Do not insert new line after ';' or ','
  (setq c-hanging-semi&comma-criteria nil)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
(setq x-select-enable-clipboard t)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; I prefer using the "clipboard" selection (the one the
        ;; typically is used by c-c/c-v) before the primary selection
        ;; (that uses mouse-select/middle-button-click)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output )))
    ;; Attach callbacks to hooks
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
    ))

;;(add-to-list 'load-path "~/temp_files/emacs/monky")
;;(load "monky")
;; (add-to-list 'load-path "~/temp_files/emacs/ahg")
;; (load "ahg")

;; directory tree plugin
(add-to-list 'load-path "~/temp_files/emacs")
(require 'dirtree)
(require 'tree-mode)
(require 'windata)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
;; For highlighting symbols
(add-to-list 'load-path "~/temp_files/emacs/highlight-symbol.el/")
(require 'highlight-symbol)
(global-set-key "\C-cha" 'highlight-symbol-at-point)
(global-set-key "\C-chn" 'highlight-symbol-next)
(global-set-key "\C-chp" 'highlight-symbol-prev)
(global-set-key "\C-chr" 'highlight-symbol-query-replace)

;; To edit several lines from fixed point
(put 'set-goal-column 'disabled nil)

;; (add-to-list 'load-path "~/temp_files/emacs/etags-select.el")
;; (require 'etags-select)

;; Define simple command to create TAGS file
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e --languages=C,C++ -R %s" "ctags" dir-name dir-name))
  )

;; (require 'git)
;; (ido-mode 1)
;; add new cc-mode compiled files to load-path d
(add-to-list 'load-path "~/temp_files/emacs/cc-mode-5.32.5")

;; Configuring auto-complete mode
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
(require 'yasnippet-bundle)

