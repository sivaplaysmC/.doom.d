(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(warning-suppress-types '((corfu-doc) (defvaralias)))
 '(which-key-allow-imprecise-window-fit t)
 '(which-key-custom-popup-max-dimensions-function '(closure (t) (_) (which-key--side-window-max-dimensions)))
 '(which-key-custom-show-popup-function
   '(closure
     (t)
     (act-popup-dim)
     (let
         ((display-buffer-in-side-window
           (symbol-function #'display-buffer-in-side-window)))
       (ignore display-buffer-in-side-window)
       (let*
           ((vnew
             #'(lambda
                 (buffer alist)
                 (+popup-display-buffer-stacked-side-window-fn buffer
                                                               (append
                                                                '((vslot . -9999)
                                                                  (select . t))
                                                                alist))))
            (old
             (symbol-function #'display-buffer-in-side-window)))
         (unwind-protect
             (progn
               (fset #'display-buffer-in-side-window vnew)
               (progn
                 (setcar act-popup-dim
                         (1+
                          (car act-popup-dim)))
                 (which-key--show-buffer-side-window act-popup-dim)))
           (fset #'display-buffer-in-side-window old)))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-rust-analyzer-inlay-face ((t (:inherit font-lock-comment-face :weight ultra-bold :height 0.83 :width extra-expanded :family "JetBrains Mono"))))
 '(show-paren-match ((t (:box nil :underline t :foreground "green" :background nil))))
 '(ts-fold-replacement-face ((t (:foreground unspecified :box nil :inherit font-lock-comment-face :weight light)))))
(put 'customize-face 'disabled nil)
(put 'customize-group 'disabled nil)
(put 'customize-variable 'disabled nil)
