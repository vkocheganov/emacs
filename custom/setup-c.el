;;;;;;;;;; Company mode ;;;;;;;;;;
;;;;;;;;;; Auto completion ;;;;;;;;;;

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))


(use-package company
  :init
;;  (global-company-mode 1)
;;  (delete 'company-semantic company-backends)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (add-hook 'c-mode-common-hook 'company-mode)
  (add-hook 'shell-mode-hook 'company-mode)
  (add-hook 'lisp-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)

  (unless (package-installed-p 'irony)
    (package-install 'irony)
    (shell-command (concat "echo " (shell-quote-argument (read-passwd "Password? "))
                           " | sudo -S apt-get install --assume-yes clang libclang-dev"))
    (call-interactively #'irony-install-server)
    )

  (use-package irony
    :config
    (add-hook 'c-mode-common-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  ;;;;;;;;;; Auto-complete c headers ;;;;;;;;;;
    (use-package company-irony-c-headers
      :config
      (add-to-list 'company-backends 'company-irony-c-headers)
      )

    (use-package company-irony
      :config
      (add-to-list 'company-backends 'company-irony)
      )

    (use-package flycheck-irony
      :config
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
      (add-hook 'c-mode-common-hook 'flycheck-mode)
      )

    (use-package irony-eldoc
      :config
      (add-hook 'irony-mode-hook #'irony-eldoc)
      )
    )
  )

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; for irony mode to work one needs to run 'irony-install-server'. Be sure to install clang + libclang-dev ;;      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'company
  (add-hook 'c-mode-common-hook 'company-mode)
  ;; (add-to-list
  ;;   'company-backends '(company-irony-c-headers company-irony))
  )
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map  [(tab)] 'company-indent-or-complete-common)
            )
          )


;;(add-hook 'after-init-hook 'global-company-mode)




;;;;;;;;;; Hide/show blocks of code ;;;;;;;;;;
;;;;;;;;; C-c @ C-M-s show all
;;;;;;;;; C-c @ C-M-h hide all
;;;;;;;;; C-c @ C-s show block
;;;;;;;;; C-c @ C-h hide block
;;;;;;;;; C-c @ C-c toggle hide/show
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "stroustrup") ;; set style to "linux"

(use-package yasnippet
  :config (use-package yasnippet-snippets)
  (yas-reload-all))
(yas-global-mode)


;;;;;;;;;;;; Highlighting ;;;;;;;;;;;;
(use-package auto-highlight-symbol
  :ensure t)
(add-hook 'c-mode-common-hook 'auto-highlight-symbol-mode)

(use-package highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)



(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

(provide 'setup-c)
