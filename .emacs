(setq shell-file-name "/bin/bash")

(load-file "~/.emacs.d/init.el")


;; —————————————————————————
;; Highlighting
;; —————————————————————————
;; highlight region between point and mark
(transient-mark-mode t)
;; highlight during query
(setq query-replace-highlight t)
;; highlight incremental search
(setq search-highlight t)
;; Show matching parenthesis. How can you live without it.
(show-paren-mode t)
;
;; —————————————————————————
;; Behaviour
;; ————————————————————————–
;; don’t make pesky backup files
(setq make-backup-files nil)
;; don’t use version numbers for backup files
(setq version-control 'never)
;; Open unidentified files in text mode
(setq default-major-mode 'text-mode)
;; Do only one line scrolling.
(setq scroll-step 1)
;; Don’t wrap long lines.
(set-default 'truncate-lines t)
;; Make the region visible (but only up to the next operation on it)
(setq transient-mark-mode t)
;; Colours (“Colors” in some other languages)
;; Give me colours in major editing modes!
(require 'font-lock)
(global-font-lock-mode t)
;; Don’t add new lines to the end of a file when using down-arrow key
(setq next-line-add-newlines nil)
;; Dont show the GNU splash screen
;(setq inhibit-startup-message t)
;; Make all “yes or no” prompts show “y or n” instead
(fset 'yes-or-no-p 'y-or-n-p)

;; —————————————————————————
;; iswitchb (work with buffers confortably)
;; —————————————————————————
;; Remember use C-x b and C-s or C-r to shift or unshift the buffer
;; also chars could be used to filter the buffer and ENTER or TAB
;; could be used to confirm the switch
(require 'iswitchb)
(iswitchb-mode)
;; iswitchb ignores
(add-to-list 'iswitchb-buffer-ignore "^ ")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*scratch*")
(add-to-list 'iswitchb-buffer-ignore "*ECB")
(add-to-list 'iswitchb-buffer-ignore "*Buffer")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "*ftp ")
(add-to-list 'iswitchb-buffer-ignore "*bsh")
(add-to-list 'iswitchb-buffer-ignore "*jde-log")
(add-to-list 'iswitchb-buffer-ignore "*GNU Emacs*")
;; —————————————————————————
;; Whites (white-space) show blanks
;; —————————————————————————
;; M-x whitespace-mode to enable
;; Reduce colors and chars in whitespace-mode
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
;; Show Pilcrow sign, etc (xahlee.org/emacs/whitespace-mode.html)
(setq whitespace-display-mappings
'(
(space-mark 32 [183] [46]) ;; Normal space
(space-mark 160 [164] [95])
(space-mark 2208 [2212] [95])
(space-mark 2336 [2340] [95])
(space-mark 3616 [3620] [95])
(space-mark 3872 [3876] [95])
(newline-mark 10 [182 10]) ; newline
(tab-mark 9 [9655 9] [92 9]) ; TAB
)
)
;

;; —————————————————————————
;; Cursor depending of mode
;; —————————————————————————
;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(setq djcb-read-only-color       "gray")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type
(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "yellow")
(setq djcb-normal-cursor-type    'bar)
(defun djcb-set-cursor-according-to-mode ()
"change cursor color and type according to some minor modes."
(cond
(buffer-read-only
(set-cursor-color djcb-read-only-color)
(setq cursor-type djcb-read-only-cursor-type))
(overwrite-mode
(set-cursor-color djcb-overwrite-color)
(setq cursor-type djcb-overwrite-cursor-type))
(t
(set-cursor-color djcb-normal-color)
(setq cursor-type djcb-normal-cursor-type))))
(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)
;

;; —————————————————————————
;; GIT Support
;; —————————————————————————
;; Requires apt-get install git-core
(load "~/.emacs.d/git-emacs/git.el")
(load "~/.emacs.d/git-emacs/git-blame.el")
(load "~/.emacs.d/lisp/vc-git.el")
(add-to-list 'vc-handled-backends 'GIT)
;; Disabled git-emacs
;(add-to-list ‘load-path “~/git-emacs-1.0/”)
;(require ‘git-emacs)
;

;; —————————————————————————
;; MSF-ABBREV
;; —————————————————————————
;; msf-abbrev configuration
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'msf-abbrev)
;; (setq msf-abbrev-verbose t) ;; optional
(setq msf-abbrev-root "~/.emacs.d/mode-abbrevs")
(global-set-key (kbd "C-c l") 'msf-abbrev-goto-root)
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)
(put 'downcase-region 'disabled nil)

;; —————————————————————————
;; WEB-MODE
;; —————————————————————————
;; web-mode.el configuration
(load "~/.emacs.d/web-mode/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;;For editing HTML files ca be done this way
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;Now I configure the plugin for CakePHP and .ctp files
(setq auto-mode-alist (cons '("\\.ctp$" . web-mode) auto-mode-alist))
