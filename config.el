;;; $DOOMDIR/config.el -*- lexical-binding: nil; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "SivaRamaKrishnan"
      user-mail-address "sivaram.asdf@gmail.com")


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka SS14" :size 18 ;; :weight 'semi-light
                           )
     doom-variable-pitch-font (font-spec :family "cascadia mono" :size 22))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! which-key
 (setq which-key-idle-delay 0.1)
 )
(after! company
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1
        ))

(after! company-box
  (setq
   company-box-frame-behavior #'point
   company-box-icons-alist 'company-box-icons-images
   ;; company-box-doc-delay 0.2
    ))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer
        lsp-rust-analyzer-server-display-inlay-hints t)

  (set-popup-rule! "^\\*cargo-run\\*" :side 'right :width .40 :modeline t)

  )

(use-package! evil-goggles
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions

  ;; (evil-goggles-use-diff-faces)
  )

(after! lsp-mode
  (setq lsp-ui-doc-use-childframe t )
  (setq lsp-clangd-binary-path "c:/msys64/mingw64/bin/clangd.exe"
        lsp-signature-render-documentation nil
        lsp-idle-delay 0.2
        )
  (set-popup-rule! "^\\*compilation\\*" :side 'right :width .40 :modeline t)

    )

(after! avy
  (setq
   avy-timeout-seconds 0.3
   avy-single-candidate-jump t
   ;; avy-keys '(?a ?s ?d ?f ?h ?j ?k ?l)

   ;; avy-keys-alist (
   ;;                  'avy-goto-line-below . '(?a ?s ?d ?f ?h ?j ?k ?l)
   ;;                  'avy-goto-line-above . '(?l ?k ?j ?h ?f ?d ?s ?a)
   ;;                  )

   avy-keys '(97 115 100 102 106 107 108 59)
   ))



(setq tab-width 4)




(map!
 :desc "Jump to line above"
 "M-;"
 'evil-avy-goto-line)


(defun my-cus-jump()
    (interactive)
    (avy-goto-line-above 1 t)
    )

(evil-define-motion evil-cool-jump (count)
       (format "Evil motion for `%s'." 'cool-jump)
       :type line
       :jump t
       :repeat abort
       (evil-without-repeat
         (evil-enclose-avy-for-motion
           (call-interactively 'my-cus-jump))))


(map!
 :desc "Jump to line below"
 "M-j"
 'evil-avy-goto-line-below  )

(map!
 :desc "Jump to line above"
 "M-k"
 'evil-cool-jump  )


(map!
:desc "Jump to word timer"
"M-SPC"
'evil-avy-goto-char-timer)


(defhydra hydra/window-nav (:hint nil)
  "
          Split: _v_ert  _s_:horz
         Delete: _c_lose  _o_thers
  Switch Window: _h_:left  _j_:down  _k_:up  _l_:right  _u_:undo  _r_:redo
        Buffers: _p_revious  _n_ext  _b_:select  _f_ind-file
          Shift: _M-h_:right          _M-j_:down           _M-k_:up         _M-l_:right
         Resize: _H_  :splitter left  _J_  :splitter down  _K_:splitter up  _L_  :splitter right
           Move: _a_:up  _z_:down  _i_menu
"
  ("z" scroll-up-line)
  ("a" scroll-down-line)
  ("i" idomenu)

  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("u" winner-undo)
  ("r" winner-redo)


  ("M-h" +evil/window-move-left)
  ("M-j" +evil/window-move-down)
  ("M-k" +evil/window-move-up)
  ("M-l" +evil/window-move-right)

  ("p" previous-buffer)
  ("n" next-buffer)
  ("b" switch-to-buffer)
  ("f" find-file)

  ("s" split-window-below)
  ("v" split-window-right)

  ("c" delete-window)
  ("o" delete-other-windows)

  ("H" hydra-move-splitter-left)
  ("J" hydra-move-splitter-down)
  ("K" hydra-move-splitter-up)
  ("L" hydra-move-splitter-right)

  ("q" nil))



(map!
    (
     :leader
     :prefix "w"
      :desc "Hydra resize" :n "SPC" #'hydra/window-nav/body))

(after! company
  (setq
   company-tooltip-maximum-width 80
   company-tooltip-minimum-width 80
   ))
