
(setq-default c-basic-offset 8)

;; —————————————————————————
;; Linum (line numbers) M-x linum-mode to enable
;; —————————————————————————
(load-file "~/.emacs.d/linum/linum-ex.el")
(require 'linum)
(setq linum-format "%d ")
;(autoload 'linum "linum" "Line numbers for buffers." t)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
