;;; init.el --- Main Emacs configuration file
;; Copyright © 2019-2021 Aabm <aabm@disroot.org>

;; Author: Aabm <aabm@disroot.org>
;; Keywords: literate programming, Emacs configuration
;; Homepage: https://gitlab.com/aabm/emacs

;;; License:
;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file LICENSE.  If not, you can visit
;; https://www.gnu.org/licenses/gpl-3.0.html or write to the Free
;; Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
;; MA 02110-1301, USA.

;;; Commentary:
;; Aabm's init settings for Emacs.
;; This file was automatically generated by `org-babel-tangle'. Do not
;; change this file. The real configuration is found in the `emacs.org'
;; file.

(when (version< emacs-version "27.1")
  (error "This requires Emacs 27.1 and above! Preferably 28 (master), but 27 should be fine..."))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq use-package-always-ensure nil)
(setq use-package-always-defer t)
(setq use-package-hook-name-suffix nil)

(straight-use-package 'diminish)

(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("elisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'."
  (let ((default-directory (expand-file-name "elisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(update-load-path)
(add-subdirs-to-load-path)

(setq load-prefer-newer t)

(setq disabled-command-function nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(blink-cursor-mode -1)

(setq focus-follows-mouse t
      mouse-autoselect-window t)

(setf mouse-wheel-scroll-amount '(3 ((shift) . 3))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t
      scroll-step 1
      scroll-conservatively 100
      disabled-command-function nil)

(setq electric-pair-pairs '((?\{ . ?\}) (?\( . ?\))
			    (?\[ . ?\]) (?\" . ?\")))
(electric-pair-mode t)

(show-paren-mode t)

(setq truncate-lines nil)

(add-hook 'text-mode-hook #'auto-fill-mode)
(diminish 'auto-fill-function)

(use-package avy
  :straight t
  :bind
  (("M-s" . avy-goto-char-2)))

(use-package olivetti
  :straight t
  :custom
  (olivetti-body-width 90)
  :bind
  (("C-c o" . olivetti-mode)))

(define-minor-mode aabm/read-mode
  "Minor Mode for better reading experience."
  :init-value nil
  :group aabm
  (if aabm/read-mode
      (progn
	(and (fboundp 'olivetti-mode) (olivetti-mode 1))
	(and (fboundp 'mixed-pitch-mode) (mixed-pitch-mode 1))
	(text-scale-set +1))
    (progn
      (and (fboundp 'olivetti-mode) (olivetti-mode -1))
      (and (fboundp 'mixed-pitch-mode) (mixed-pitch-mode -1))
      (text-scale-set 0))))

(use-package pdf-tools
  :straight t
  :init
  (pdf-loader-install)
  :custom
  (pdf-view-resize-factor 1.1)
  (pdf-view-continuous nil)
  (pdf-view-display-size 'fit-page))

(use-package which-key
  :straight t
  :diminish which-key-mode
  :init
  (which-key-mode)
  :custom
  (which-key-idle-delay 0.4))

(use-package selectrum
  :straight t
  :init
  (selectrum-mode))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless))
  (orderless-skip-highlighting (lambda () selectrum-is-active))
  (selectrum-highlight-candidates-function #'orderless-highlight-matches))

(use-package selectrum-prescient
  :straight t
  :custom
  (selectrum-prescient-enable-filtering nil)
  :config
  (selectrum-prescient-mode)
  (prescient-persist-mode))

(use-package consult
  :straight t
  :bind
  (("M-y" . consult-yank)
   ("C-x b" . consult-buffer)
   ("M-g g" . consult-goto-line)
   ("C-x r b" . consult-bookmark)))

(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(use-package geiser
  :straight geiser-guile
  :init
  (setq geiser-active-implementations '(guile)))

(defun split-window-below-and-follow ()
  "A simple replacement for `split-window-below', which automatically focuses the new window."
  (interactive)
  (split-window-below)
  (other-window 1))

(defun split-window-right-and-follow ()
  "A simple replacement for `split-window-right', which automatically focuses the new window."
  (interactive)
  (split-window-right)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-window-below-and-follow)
(global-set-key (kbd "C-x 3") 'split-window-right-and-follow)

(global-set-key (kbd "M-o") 'other-window)

(defun kill-this-buffer+ ()
  "Kill the current buffer. More reliable alternative to `kill-this-buffer'"
  (interactive)
  (kill-buffer))

(global-set-key (kbd "C-x k") 'kill-this-buffer+)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package dired
  :custom
  (dired-listing-switches "-alNF --group-directories-first")
  (wdired-allow-to-change-permissions t)
  :config
  (defun dired-up-alternate-directory ()
    (interactive)
    (find-alternate-file ".."))

  (defun dired-xdg-open ()
    "Open the marked files using xdg-open."
    (interactive)
    (let ((file-list (dired-get-marked-files)))
      (mapc
       (lambda (file-path)
	 (let ((process-connection-type nil))
	   (start-process "" nil "xdg-open" file-path)))
       file-list)))
  :bind
  (:map dired-mode-map
	(("l" . dired-up-alternate-directory)
	 ("RET" . dired-find-alternate-file)
	 ("M-RET" . dired-find-file)
	 ("v" . dired-xdg-open))))

(use-package dired-hide-dotfiles
  :straight t
  :hook
  ((dired-mode-hook . dired-hide-dotfiles-mode))
  :bind
  (:map dired-mode-map
	(("h" . dired-hide-dotfiles-mode))))

(use-package vc
  :config
  (defvar aabm-vc-shell-output "*aabm-vc-output*")
  (defun aabm-vc-git-log-grep (pattern &optional diff)
    "Run ’git log --grep’ for PATTERN.
  With optional DIFF as a prefix (\\[universal-argument])
  argument, also show the corresponding diffs. 

This function was taken from prot."
    (interactive
     (list (read-regexp "Search git log for PATTERN: ")
	   current-prefix-arg))
    (let* ((buf-name aabm-vc-shell-output)
	   (buf (get-buffer-create buf-name))
	   (diffs (if diff "-p" ""))
	   (type (if diff 'with-diff 'log-search))
	   (resize-mini-windows nil))
      (shell-command (format "git log %s --grep=%s -E --" diffs pattern) buf)
      (with-current-buffer buf
	(setq-local vc-log-view-type type)
	(setq-local revert-buffer-function nil)
	(vc-git-region-history-mode))))
  :bind
  (:map vc-prefix-map
	(("S" . aabm-vc-git-log-grep))))

(defun delete-this-file ()
  (interactive)
  (delete-file (buffer-file-name)))

(defun delete-this-file-and-buffer ()
  (interactive)
  (delete-file (buffer-file-name))
  (kill-buffer))

(use-package org
  :custom
  (org-cycle-global-at-bob t)
  (org-hide-leading-stars t)
  :bind
  (:map org-mode-map
	(("M-n" . org-forward-element)
	 ("M-p" . org-backward-element)
	 ("C-M-n" . org-metadown)
	 ("C-M-p" . org-metaup)
	 ("C-M-f" . org-metaright)
	 ("C-M-b" . org-metaleft))))

(use-package org
  :custom
  (org-src-tab-acts-natively t)
  (org-src-fontify-natively t)
  (org-src-window-setup 'current-window)
  (org-structure-template-alist
   '(("a" . "export ascii")
     ("c" . "center")
     ("C" . "comment")
     ("ee" . "export")
     ("eh" . "export html")
     ("el" . "export latex")
     ("E" . "example")     
     ("q" . "quote")
     ("ss" . "src")
     ("se" . "src emacs-lisp :tangle init.el\n")
     ("v" . "verse"))))

(use-package org
  :bind
  (("C-c w" . org-capture)))
  ;; :custom
  ;; (org-capture-templates))

(use-package org-roam
  :straight t
  :diminish org-roam-mode
  :config
  (org-roam-mode)
  :custom
  (org-roam-directory "~/org/roam/")
  (org-roam-index-file "~/org/roam/index.org")
  (org-roam-encrypt-files t)
  (org-roam-completion-system 'default)
  (org-roam-db-update-method 'immediate)
  (org-roam-graph-executable "/usr/bin/neato")
  (org-roam-graph-extra-config '(("overlap" . "false")))
  (org-roam-capture-templates
   '(("o" "Show: overview" plain (function org-roam--capture-get-point)
      "#+date:%T\n#+startup: overview\n#+roam_alias:\n"
      :file-name "%<%Y%m%d%H%M%S>-${slug}"
      :head "#+title: ${title}\n"
      :unnarrowed t)
     ("a" "Show: all" plain (function org-roam--capture-get-point)
      "#+date:%T\n#+startup: showall\n#+roam_alias:\n"
      :file-name "%<%Y%m%d%H%M%S>-${slug}"
      :head "#+title: ${title}\n"
      :unnarrowed t))) 
  :bind
  (("C-c n f" . org-roam-find-file)
   ("C-c n l" . org-roam-insert)
   ("C-c n L" . org-roam-insert-immediate)
   ("C-c n r" . org-roam-random-note)
   ("C-c n w" . org-roam-capture)))

(use-package elfeed
  :straight t
  :config
  (load-file (expand-file-name "personal/feeds.el" user-emacs-directory))
  :hook
  ((elfeed-show-mode-hook . aabm/read-mode))
  :bind
  (("C-c e" . elfeed)))

(load-theme 'wheatgrass t)

(add-to-list 'default-frame-alist '(font . "Iosevka medium extended 10"))
(set-frame-font "Iosevka medium extended 10" nil t)

(line-number-mode t)
(column-number-mode t)
