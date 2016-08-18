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


;;(add-to-list 'load-path "~/.emacs.d/github_emacs/monky")
;;(load "monky")
;; (add-to-list 'load-path "~/.emacs.d/github_emacs/ahg")
;; (load "ahg")

;; directory tree plugin
(add-to-list 'load-path "~/.emacs.d/github_emacs")
(require 'dirtree)
(require 'tree-mode)
(require 'windata)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
;; For highlighting symbols
(add-to-list 'load-path "~/.emacs.d/github_emacs/highlight-symbol.el/")
(require 'highlight-symbol)
(global-set-key "\C-cha" 'highlight-symbol-at-point)
(global-set-key "\C-chn" 'highlight-symbol-next)
(global-set-key "\C-chp" 'highlight-symbol-prev)
(global-set-key "\C-chr" 'highlight-symbol-query-replace)

;; To edit several lines from fixed point
(put 'set-goal-column 'disabled nil)

;; (add-to-list 'load-path "~/.emacs.d/github_emacs/etags-select.el")
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
(add-to-list 'load-path "~/.emacs.d/github_emacs/cc-mode-5.32.5")

;; Configuring auto-complete mode
;; to install auto complete mode execute load-file "<ac_folder>/etc/install.el
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
;; add own dictionary for autocomplete
(add-to-list 'ac-user-dictionary-files "~/.emacs.d/github_emacs/auto-complete-1.3.1/dict/vic_ac_dictionary")
;; different templates for c/c++ structures
(require 'yasnippet-bundle)

;; Indent after pressing RET
(global-set-key (kbd "RET") 'newline-and-indent)

;; (add-to-list 'load-path "~/.emacs.d/github_emacs/auto-complete-ctags")
;; (require 'auto-complete-ctags-cpp)

;; Latex
(require 'ac-math)
(defun my-latex-mode-hook ()
  (auto-complete-mode 1)
  (linum-mode 1)
  ;; Enable autocomplition mode
  )
(add-hook 'latex-mode-hook 'my-latex-mode-hook)


;; Fit to page for doc-view (for latex)
(add-to-list 'load-path "~/.emacs.d/github_emacs/doc-view-fit-to-page")
(require 'doc-view-fit-page)
(add-hook 'doc-view-mode-hook
          '(lambda ()
             (doc-view-fit-page)))

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
