;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(beacon-mode 1)
(xclip-mode 0)
(focus-mode t)
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;
(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "Hack" :size 20))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;;
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-gruvbox)
(custom-set-faces
'(default ((t (:background "#1a1a1a" :foreground "#a9b1d6")))))

(setq doom-one-brighter-comments t
      doom-one-comment-bg nil)

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic)

;; red is too aggressive, so let's make it orange
  '(doom-modeline-buffer-modified :foreground "orange"))

 ;; opacity
(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 76))

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(75 . 50) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)


(setq doom-modeline-height 40)
;; add the battery status to our modeline.
(after! doom-modeline
  (let ((battery-str (battery)))
    (unless (or (equal "Battery status not available" battery-str)
                (string-match-p (regexp-quote "unknown") battery-str)
                (string-match-p (regexp-quote "N/A") battery-str))
      (display-battery-mode 1))))
(display-time-mode 1) ; show time and date
(setq display-time-format "%Y-%m-%d %H:%M") ; time and date format

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Display mode with letter instead of icon
(setq doom-modeline-modal-icon nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; force doom to open at dashboard
;;(setq doom-fallback-buffer-name "*dashboard*")

;; set opacity of frames
(add-to-list 'default-frame-alist '(alpha-background . 80))

;; backup files
(setq auto-save-default t
      make-backup-files t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; Move cursor past last character with S-$
(setq evil-move-beyond-eol t)
;;
;; Show status bar always
;;(after! core-ui (menu-bar-mode 1))
(menu-bar-mode 1)

;; Disable toolbar
(tool-bar-mode 0)
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
;;
(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :config
  (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))

(use-package! dired-hide-dotfiles
  :after dired
  :hook (dired-mode . dired-hide-dotfiles-mode)

  :config
  (map! :map dired-mode-map
        :desc "Hide dot files"   :n "zo" (lambda () (interactive) (dired-hide-dotfiles-mode 0))
        :desc "Show dot files"   :n "zm" (lambda () (interactive) (dired-hide-dotfiles-mode 1))
        :desc "Toggle dot files" :n "za" #'dired-hide-dotfiles-mode
        :desc "Toggle dot files" :n "z." #'dired-hide-dotfiles-mode))

(use-package! peep-dired
  :after dired
  :config
  (add-hook 'peep-dired-hook 'evil-normalize-keymaps)
  (map! :map dired-mode-map
        :desc "Preview a file" :n "p" #'peep-dired

        :map peep-dired-mode-map
        :desc "Preview next file"        :n "kk" #'peep-dired-prev-file
        :desc "Preview prev file"        :n "jj" #'peep-dired-next-file
        :desc "Scroll preview pane up"   :n "C-k" #'peep-dired-scroll-page-up
        :desc "Scroll preview pane down" :n "C-j" #'peep-dired-scroll-page-down)

  (setq
   peep-dired-cleanup-eagerly nil
   peep-dired-cleanup-on-disable t))


;; - `after!' for running code after a package has loaded
;;
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new kers
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(defun my-split-vertical ()
    (interactive)
    (split-window-vertically)
    (other-window 1))

(defun my-split-horizontal ()
    (interactive)
    (split-window-horizontally)
    (other-window 1))

(global-set-key (kbd "C-x C-v") 'my-split-vertical)
(global-set-key (kbd "C-x C-h") 'my-split-horizontal)

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines"      "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers"            "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines))

;;Exit insert mode by pressing k and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(key-chord-define evil-visual-state-map "kj" 'evil-normal-state)
(key-chord-mode 1)

;; ;; change cursor color and shape, depending on the mode

(setq evil-normal-state-cursor '(box "dodger blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))


(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file"           "d v" #'dired-view-file)))


(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;; movig lines up and down plugin
(drag-stuff-global-mode 1)
;; To activate the suggested key-bindings, <M-up>, <M-down>, <M-right>, <M-left>, use:
(drag-stuff-define-keys)

(setq doom-themes-treemacs-theme "doom-colors")

;; movig lines up and down plugin
(drag-stuff-global-mode 1)
;; To activate the suggested key-bindings, <M-up>, <M-down>, <M-right>, <M-left>, use:
(drag-stuff-define-keys)

    (defun kill-dired-buffers ()
	 (interactive)
	 (mapc (lambda (buffer)
           (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
             (kill-buffer buffer)))
         (buffer-list)))

    (defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

    (map! :leader
   :desc "kill-dired-buffers"      "k" #'kill-dired-buffers
   :desc "kill-non-dired-buffers"      "K" #'kill-other-buffers)


        (global-set-key (kbd "M-Q") #'quit-window)
        (global-set-key (kbd "M-W") #'save-buffer)


;; make :q and :wq work the way I like them (thanks ChatGPT)
(defun my-kill-buffer-or-window ()
  "Kill the buffer, or close the window if there's only one.
   Prompts to save the buffer if it's unsaved."
  (interactive)
  (if (one-window-p)
      (progn
        (when (and (buffer-modified-p)
                   (eq (read-char-choice
                        "Buffer modified. Save buffer? (y/n/C)"
                        '(?y ?n ?C))
                       ?y))
          (save-buffer))
        (kill-buffer))
    (delete-window)))


(evil-ex-define-cmd "q[uit]" 'my-kill-buffer-or-window)

(defun my-evil-save-and-close ()
  (interactive)
  (save-buffer)
  (my-kill-buffer-or-window)
  )

(evil-ex-define-cmd "wq" 'evil-save-and-close)

(map! :leader
      :desc " save "      "w w" #'save-buffer)

(map! :leader
      :desc " save and quit "      "w q" #'save-buffers-kill-emacs)

(define-key evil-normal-state-map (kbd "RET") 'newline)

(map! :leader
      :desc "Zap to char"    "z" #'zap-to-char
      :desc "Zap up to char" "Z" #'zap-up-to-char)
;; Resize windows (requires hydra package)
;;
(defhydra doom-window-resize-hydra (:hint nil)
  "
             _k_ increase height
_h_ decrease width    _l_ increase width
             _j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)

  ("q" nil))

(map!
    (:prefix ";"
      :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body))
;;--------------------------------------------------------------------------

(use-package! openwith
  :after-call pre-command-hook
  :config
  (openwith-mode t)
  (add-to-list 'openwith-associations '("\\.pdf\\'" "qpdfview" (file)))
  (add-to-list 'openwith-associations '("\\.xls\\'" "libreoffice --calc" (file)))
  (add-to-list 'openwith-associations '("\\.xls\\'" "libreoffice --calc" (file)))
  (add-to-list 'openwith-associations '("\\.doc\\'" "libreoffice --writer" (file)))
  (add-to-list 'openwith-associations '("\\.docx\\'" "libreoffice --writer" (file))))

(use-package nix-mode
  :mode "\\.nix\\'")

;; Auto save buffers on focus lost
(add-function :after after-focus-change-function (lambda () (save-some-buffers t)))
;; Exit insert mode on focus loss
(add-function :after after-focus-change-function (lambda () (evil-normal-state)))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
