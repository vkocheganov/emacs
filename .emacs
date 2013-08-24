(setq inhibit-startup-screen 1)
(setq-default indent-tabs-mode nil)
(column-number-mode 1)
(global-unset-key "\C-s")
(global-set-key "\C-ss" `isearch-forward)
(global-set-key "\C-cs" `shell)
(global-set-key "\C-sk" `kill-whole-line)
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)
(global-set-key "\C-cb" 'windmove-left) 
(global-set-key "\C-cf" 'windmove-right)
(global-set-key "\C-cp" 'windmove-up) 
(global-set-key "\C-cn" 'windmove-down)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; To enable emacs client
(server-start)

(defun my-c-mode-common-hook ()
  (c-set-style "Stroustrup")
  (linum-mode 1)
  (electric-indent-mode t)
  (auto-complete-mode 1)
  (setq c-basic-offset 4)
  (setq c-auto-newline 1)
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

                                        ;(add-to-list 'load-path "~/temp_files/emacs/monky")
                                        ;(load "monky")
(add-to-list 'load-path "~/.emacs.d/github_emacs/ahg")
(load "ahg")

;; directory tree plugin
(add-to-list 'load-path "~/.emacs.d/github_emacs")
(require 'dirtree)
(require 'tree-mode)
(require 'windata)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)

(add-to-list 'load-path "~/.emacs.d/github_emacs/highlight-symbol.el/")
(require 'highlight-symbol)
(global-set-key "\C-cha" 'highlight-symbol-at-point)
(global-set-key "\C-chn" 'highlight-symbol-next)
(global-set-key "\C-chp" 'highlight-symbol-prev)
(global-set-key "\C-chr" 'highlight-symbol-query-replace)

(put 'set-goal-column 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/github_emacs/etags-select.el")
(require 'etags-select)

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e --languages=C,C++ -R %s" "ctags" dir-name dir-name))
  )

(require 'git)
;;(ido-mode 1)
;;add new cc-mode compiled files to load-path d
(add-to-list 'load-path "~/.emacs.d/github_emacs/cc-mode-5.32.5")

;; to install auto complete mode execute load-file "<ac_folder>/etc/install.el
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
;; add own dictionary for autocomplete
(add-to-list 'ac-user-dictionary-files "~/.emacs.d/github_emacs/vic_ac_dictionary")

;; different templates for c/c++ structures
(require 'yasnippet-bundle)
