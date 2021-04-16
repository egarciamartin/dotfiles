;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Eva Garcia Martin"
      user-mail-address "eva.g.596@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Monoki Nerd Font" :size 12 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "Monoki Nerd Font" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
 ; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(cond (IS-MAC
       (setq mac-command-modifier      'meta
             mac-option-modifier       'alt
             mac-right-option-modifier 'super)))


(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
  (setq conda-env-home-directory (expand-file-name "~/anaconda3")))

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

;; Enable elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;; Enable Flycheck
;;(when (require 'flycheck nil t)
;; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;; (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Flyspell
(add-hook 'org-mode-hook 'flyspell-mode)


;; to solve the error Your ‘python-shell-interpreter’ doesn’t seem to support readline
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

(setq fancy-splash-image "~/.doom.d/black-hole.png")

;; to be able to use C-u as the universal argument
(setq! evil-want-C-u-scroll nil
       evil-want-C-u-delete nil)

;; Removing the vertical bars from elpy
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

;; These are to try and fix the highlighting for the spacemacs theme,
;; cause it had a horrible horrible yellow.
;; The issue is that in order to set the color with 'hl-line, you need to load FIRST
;; global-hl-line-mode. Answer: https://stackoverflow.com/questions/17701576/changing-highlight-line-color-in-emacs

(global-hl-line-mode 1)
(set-face-background 'hl-line "gray13")

;; remove confirmation exit
(setq confirm-kill-emacs nil)
