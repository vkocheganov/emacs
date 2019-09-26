;;;;;;;;;; Company mode ;;;;;;;;;;
;;;;;;;;;; Auto completion ;;;;;;;;;;
(use-package company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; for irony mode to work one needs to run 'irony-install-server'. Be sure to install clang + libclang-dev ;;      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(unless (package-installed-p 'irony)
  (package-install 'irony)
  (shell-command (concat "echo " (shell-quote-argument (read-passwd "Password? "))
                         " | sudo -S apt-get install --assume-yes clang libclang-dev"))
  (call-interactively #'irony-install-server)
  )

(use-package irony
  :config
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )
(use-package company-irony
  :config
  (add-to-list 'company-backends 'company-irony)
  )
(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  )
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
;;(add-hook 'after-init-hook 'global-company-mode)


;;;;;;;;;; Auto-complete c headers ;;;;;;;;;;
(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers))

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

(provide 'setup-c)
