
;; Window switching
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x -") 'toggle-window-split)
(global-set-key (kbd "C-x C--") 'rotate-windows)
(global-unset-key (kbd "C-x C-+")) ;; don't zoom like this


;; Expand region (increases selected region by semantic units)
(global-set-key (if is-mac (kbd "C-@") (kbd "C-'")) 'er/expand-region)

;; Quickly jump in document with ace-jump-mode
(define-key global-map (kbd "C-ø") 'ace-jump-mode)

;; Find file in project
(global-set-key (kbd "C-x o") 'find-file-in-project)

(provide 'key-bindings)
         
