;; General Settings
(push "/usr/local/bin" exec-path)
(set-default 'truncate-lines t)
(setq x-select-enable-clipboard t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq max-mini-window-height 1)
(setq eval-expression-debug-on-error nil)
(setq stack-trace-on-error nil)
(setq debug-on-error nil)
(menu-bar-mode 0)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(fset 'yes-or-no-p 'y-or-n-p)
(setq recentf-keep '(file-remote-p file-readable-p))



(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode t)
(icomplete-mode t)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)
(recentf-mode 1)
(setq scroll-step            1
      scroll-conservatively  10000)

;; Load path

(add-to-list 'load-path "~/.emacs.d/vendors/")
(add-to-list 'load-path "~/.emacs.d/vendors/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/vendors/emacs-color-theme-solarized")
(add-to-list 'load-path "~/.emacs.d/vendors/cucumber.el")
(add-to-list 'load-path "~/.emacs.d/vendors/magit")
(add-to-list 'load-path "~/.emacs.d/vendor/jade-mode")
(require 'jade-mode)  
(require 'sws-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
;;(require 'color-theme)
;;(setq color-theme-is-global t)
;;(color-theme-charcoal-black)
;;lambda nil (color-theme 'color-theme-robin-hood (current-buffer)))


(require 'feature-mode)
;;Winner-mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

;;Linumbering
(require 'linum+)

(require 'color-theme-buffer-local)

;; AUto-Completion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/bpinkney/.emacs.d/vendors/ac-dict")
(ac-config-default)

(require 'color-theme-solarized)
(setq solarized-contrast "high")

;; Fork the work (async) of pushing to mobile
;; https://gist.github.com/3111823 ASYNC org mobile push...
(require 'gnus-async) 
;; Define a timer variable
(defvar org-mobile-push-timer nil
  "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")
;; Push to mobile when the idle timer runs out
(defun org-mobile-push-with-delay (secs)
  (when org-mobile-push-timer
    (cancel-timer org-mobile-push-timer))
  (setq org-mobile-push-timer
        (run-with-idle-timer
         (* 1 secs) nil 'org-mobile-push)))
;; After saving files, start an idle timer after which we are going to push 
(add-hook 'after-save-hook 
 (lambda () 
   (if (or (eq major-mode 'org-mode) (eq major-mode 'org-agenda-mode)
       (org-mobile-push-with-delay 10))
   )))
;; Run after midnight each day (or each morning upon wakeup?).
(run-at-time "00:01" 86400 '(lambda () (org-mobile-push-with-delay 1)))
;; Run 1 minute after launch, and once a day after that.
(run-at-time "1 min" 86400 '(lambda () (org-mobile-push-with-delay 1)))


;; Org Mode Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(ecb-options-version "2.40")
 '(max-mini-window-height 0.25)
 '(org-agenda-dim-blocked-tasks (quote invisible))
 '(org-agenda-files (quote ("~/Pictures/.users2.org" "~/Dropbox/org/internap.org")))
 '(org-disputed-keys (quote (([(shift up)] . [(meta p)]) ([(shift down)] . [(meta n)]) ([(shift left)] . [(meta -)]) ([(shift right)] . [(meta =)]) ([(control shift right)] . [(meta shift +)]) ([(control shift left)] . [(meta shift -)]))))
 '(org-enforce-todo-dependencies t)
 '(org-mobile-files (quote (org-agenda-files "~/Documents/org")))
 '(org-refile-targets (quote (("internap.org" :maxlevel . 2) ("corksquare.org" :maxlevel . 2) ("main.org" :maxlevel . 2) ("fivestar.org" :maxlevel . 2))))
 '(org-replace-disputed-keys t)
 '(org-startup-folded nil)
 '(org-tags-column 80)
 '(org-use-fast-todo-selection t)
 '(show-paren-mode t)
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#ffffff")
 '(tool-bar-mode nil))
 '(term-default-bg-color "#000000")        ;; background color (black)
 '(term-default-fg-color "#dddd00")       ;; foreground color (yellow)

(setq org-directory "~/Documents/org")
(setq org-mobile-inbox-for-pull "~/Documents/org/inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))


(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/global-mode 1)

;; Multi-Term
  (require 'multi-term)
  (autoload 'multi-term "multi-term" nil t)
  (autoload 'multi-term-next "multi-term" nil t)

  (setq multi-term-program "/bin/bash")   ;; use bash

  (add-hook 'term-mode-hook
  #'(lambda () (setq autopair-dont-activate t)))

  (global-set-key (kbd "C-c t") 'multi-term-next)  
  (global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

;; Customized look
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "microsoft" :family "Consolas"))))
 '(cursor ((t (:background "white"))))
 '(fringe ((((class color) (background dark)) (:background "black"))))
 '(magit-diff-add ((t (:foreground "green"))))
 '(magit-diff-del ((t (:foreground "Red"))))
 '(magit-item-highlight ((t (:background "royal blue"))))
 '(mode-line ((t (:background "blue" :foreground "white" :height 1.0))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) nil)))
 '(mode-line-inactive ((t (:background "#8a8a8a" :foreground "black" :weight light :height 1.0))))
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "Black"))))
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "#333333")))))

;; Key Settings

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
(global-set-key "\C-ct" 'org-todo)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'copy-region-as-kill)
(global-set-key "\C-c C-a" 'org-attach)
(global-set-key (kbd "C-c r") 'recentf-open-files)
(global-set-key (kbd "C-x t") 'multi-term)
(global-set-key (kbd "\C-k") 'kill-whole-line)
(global-set-key (kbd "\C-x m") 'magit-status)
(global-set-key (kbd "C-v") 'x-clipboard-yank)
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

(iswitchb-mode 1)
    (defun iswitchb-local-keys ()
      (mapc (lambda (K) 
	            (let* ((key (car K)) (fun (cdr K)))
		              (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	        '(("<right>" . iswitchb-next-match)
		        ("<left>"  . iswitchb-prev-match)
			      ("<up>"    . ignore             )
            ("<down>"  . ignore             )
            )
          )
      )

    (add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)
(setq iswitchb-buffer-ignore '("^ " "*Buffer" "*Messages*" "*scratch"))

;; Required
(require 'magit)

;; Hooks

;; MuMaMo-Mode for rhtml files
;(add-to-list 'load-path "~/path/to/your/elisp/nxml-directory/util")
;(require 'mumamo-fun)
;(setq mumamo-chunk-coloring 'submode-colored)
;(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
;(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))


(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gumfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))


(require 'color-theme-buffer-local)
(add-hook 'ruby-mode-hook 
          (lambda nil (color-theme-buffer-local 'color-theme-solarized-light (current-buffer))))

(setq auto-mode-alist  (cons '("Gemfile$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Guardfile$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Rakefile$" . ruby-mode) auto-mode-alist))


(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))
(put 'dired-find-alternate-file 'disabled nil)
(put 'erase-buffer 'disabled nil)

