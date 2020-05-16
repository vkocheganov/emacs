



;; (use-package multi-term)
;; (setq multi-term-program "/bin/bash")
;; (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)

;; (add-to-list 'load-path "/home/vkocheganov/thirdparty/emacs-libvterm/")
;; (require 'vterm)

(use-package multiple-cursors)




(defun vterm--rename-buffer-as-title (title)
  (let ((dir (string-trim-left (concat (nth 1 (split-string title ":")) "/"))))
    (cd-absolute dir)
    ))
(add-hook 'vterm-set-title-functions #'vterm--rename-buffer-as-title)


;; (add-to-list 'load-path "~/.emacs.d/")
;; (require 'sunrise)


(use-package openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))
(setq openwith-associations '(("\\.avi\\'" "vlc" (file))))


(setq dired-listing-switches "-alh")


(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message "Size of all marked files: %s"
               (progn
                 (re-search-backward "\\(^[0-9.,]+[A-Za-z]+\\).*total$")
                 (match-string 1))))))

(define-key dired-mode-map (kbd "?") 'dired-get-size)

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
(global-set-key (kbd "C-<f5>") 'compile)

(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "/home/vkocheganov/mounted/NAS/homes_Viktor.Kocheganov/VDC/data/")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(find-file "/ssh:ts13:/home/vkocheganov/link_training/vic_models/")))
(global-set-key (kbd "<f8>") (lambda() (interactive)(find-file "/ssh:dl4:/home/vkocheganov/VDC/VideoAnnotation/")))
;; (load "/home/vkocheganov/.emacs.d/elpa/dired-launch-20180607.1841/dired-launch.el")
;; (dired-launch-enable)
;; (setq dired-launch-default-launcher '("xdg-open"))

;; (load "/home/vkocheganov/Development/github_sources/emacs/custom/diredp.el")


;; (org-babel-load-file (expand-file-name "/home/vkocheganov/Development/github_sources/emacs/config.org"))
(org-babel-load-file (expand-file-name "/home/vkocheganov/thirdparty/emacs/README.org"))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet-classic-snippets which-key openwith yasnippet-snippets ws-butler volatile-highlights use-package undo-tree sr-speedbar multiple-cursors magit ivy-rtags irony-eldoc iedit highlight-symbol helm-swoop helm-projectile flycheck-rtags flycheck-irony dtrt-indent company-shell company-irony-c-headers company-irony comment-dwim-2 clean-aindent-mode auto-highlight-symbol anzu anaconda-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
