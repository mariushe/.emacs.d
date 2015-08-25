;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Add information about which column the cursor is currently on in the mode line
(column-number-mode)

;; Makes emacs run fullscreen
(custom-set-variables '(initial-frame-alist (quote ((fullscreen . maximized)))))


;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))


;; Set up load path
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path settings-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
(require 'appearance)

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))


;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; set mac data
(when is-mac (require 'mac))

;; Setup packages
(require 'setup-package)
(require 'dash)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(paredit
     smartparens
     clojure-mode
     clojure-mode-extra-font-locking
     cider
     rainbow-delimiters
     flycheck-clojure
     markdown-mode
     flycheck
     flx-ido
     ido-vertical-mode
     ido-at-point
     yasnippet
     better-defaults
     aggressive-indent)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

;; Setup environment variables from the user's shell.
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; Setup extensions
(require 'setup-paredit)
(require 'setup-yasnippet)

(require 'find-file-in-project)
(require 'ace-jump-mode)
(require 'eproject)
(require 'aggressive-indent)

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)
(--each '(markdown-mode)
  (add-hook it 'turn-on-smartparens-mode))

;;(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'flycheck '(require 'setup-flycheck))

;; Language specific setup files
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))


(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)

;; Map files to modes
(require 'mode-mappings)

;; Setup key bindings
(require 'key-bindings)

(require 'expand-region)
(require 'multiple-cursors)


