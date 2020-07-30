;;; xorns-git --- Integrate Emacs with GIT using `magit'

;; Copyright (C) 2014-2015 Merchise

;; Author: Medardo Rodriguez <med@merchise.org>
;; URL: http://dev.merchise.org/emacs/xorns-git
;; Keywords: initialization, merchise, convenience
;; Version: 20150516.1620

;; This file is NOT part of GNU Emacs but I'd like it. ;)

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>
;; or type `C-h C-c' in Emacs.

;;; Commentary:

;; Configure all GIT preferences using `magit'.
;;
;; This module is automatically used when::
;;
;;     (require 'xorns)

;; Enjoy!


;;; Code:


(require 'ispell)
(require 'magit nil 'noerror)


(when (xorns-configure-p 'basic)
  (if (featurep 'magit)
    (progn
      (global-set-key "\C-xg" 'magit-status)
      (add-hook 'git-commit-mode-hook  ; run when in `magit' mode
	(lambda ()
	  (condition-case err
	    (progn
	      (turn-on-auto-fill)
	      (flyspell-mode nil)
	      ;; TODO: Use .dir-locals.el
	      (ispell-change-dictionary "english"))
	    (error (message "error@git-commit-mode-hook: %s" err))))))
    ;else
    (xorns-missing-feature 'magit)))


;;;###autoload
(defun xorns-git-dependencies-install ()
  "Install all dependencies for `git' modes."
  (xorns-dependency-install 'magit))


(provide 'xorns-git)
;;; xorns-git.el ends here
