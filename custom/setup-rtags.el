;; In order to use rtags one should install it:
;; git clone --recursive https://github.com/Andersbakken/rtags.git && cd rtags && make && sudo make install
;;
;; And create .dir-locals.el at project root:
;; ((nil . ((cmake-ide-build-dir . "/home/vkocheganov/thirdparty/opencv/build"))))
;;
;; To make cmake-ide work one needs project to be compiled with following flag:
;; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
;; If you don't have cmake, you should do something like:
;; bear --append make -j16
;; See https://vxlabs.com/2016/04/11/step-by-step-guide-to-c-navigation-and-completion-with-emacs-and-the-clang-based-rtags/
;; for more details

(use-package rtags)
(require 'rtags)
(use-package cmake-ide)
(cmake-ide-setup)
(rtags-enable-standard-keybindings c-mode-base-map "\C-xr")
(define-key c-mode-base-map (kbd "M-.")
  (function rtags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,")
  (function rtags-find-references-at-point))


;; comment this out if you don't have or don't use helm
(setq rtags-use-helm t)
;; company completion setup
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
;; (global-company-mode)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
;; use rtags flycheck mode -- clang warnings shown inline
(use-package flycheck-rtags)
;; c-mode-common-hook is also called by c++-mode

(defun setup-flycheck-rtags ()
  (interactive)
  (flycheck-select-checker 'rtags)
  ;; RTags creates more accurate overlays.
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))
(add-hook 'c-mode-common-hook #'setup-flycheck-rtags)



(provide 'setup-rtags)
