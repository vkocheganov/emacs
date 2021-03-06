;;
;; Configure ansi-term launch
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
(global-set-key (kbd "M-RET") 'ansi-term)
(defalias 'yes-or-no-p 'y-or-n-p)

;;
;; Kill current buffer if no args passed
;; Act as usual kill if run with C-u
(defun victor-kill-buffer (arg)
  "kill current buffer"
  (interactive "P")
  (if arg
    (call-interactively 'kill-buffer)
      (kill-buffer)
  ))
(global-set-key (kbd "C-x k") 'victor-kill-buffer)

;; move cursor more continuosly at the window end
(setq scroll-conservatively 100)

;;
;; Highlight current line
(global-hl-line-mode t)
(set-face-background hl-line-face "gray13")
;; (set-face-attribute hl-line-face nil  :foreground "white")
;; (set-face-attribute hl-line-face nil :underline t)
(set-face-background 'highlight "gray13")
(set-face-foreground 'highlight nil)
;; (set-face-underline-p 'highlight t)

;;
;; When scrolling beacon mode shortly highlights last line
(use-package beacon
  :ensure t
  :init )
(beacon-mode 1)

(setq make-backup-files nil)

;; This is likely usefull in terminal
;; (use-package org-bullets
;; :ensure t
;; :config 
;; (add-hook  'org-mode-hook (lambda () (org-bulltes-mode))))

(define-key org-mode-map (kbd "C-c C-c") 'org-edit-src-code)
