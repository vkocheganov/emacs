(setq inhibit-startup-screen 1)
(column-number-mode 1)
(global-unset-key "\C-s")
(global-set-key "\C-ss" `isearch-forward)
(global-set-key "\C-cs" `shell)
(global-set-key "\C-sk" `kill-whole-line)
(global-set-key "\C-xra" `append-to-register)
(global-set-key "\C-xrp" `prepend-to-register)
(global-set-key [M-left] 'windmove-left) 
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up) 
(global-set-key [M-down] 'windmove-down)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun my-c-mode-common-hook ()
(c-set-style "Stroustrup")
(linum-mode 1)
(electric-indent-mode t)
(setq c-basic-offset 4)
(setq c-auto-newline 1)
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
