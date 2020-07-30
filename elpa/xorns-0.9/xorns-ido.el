;;; xorns-ido ---  Configuration for ido

;; Copyright (C) 2014-2015 Merchise

;; Author: Medardo Rodriguez <med@merchise.org>
;; URL: http://dev.merchise.org/emacs/xorns-all
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

;; Definitions that depends of all `xorns' sub-modules.

;; Enjoy!


;;; Code:

(require 'ido)
(require 'xorns-utils)


(defun -xorns-customize-ido ()
  "Customize `ido' for vertical appearance."
  (setq ido-decorations
    (quote ("\n-> " "" "\n " "\n ..." "[" "]"
	     " [No match]" " [Matched]" " [Not readable]"
	     " [Too big]" " [Confirm]")))

  (defun ido-disable-line-truncation ()
    (set (make-local-variable 'truncate-lines) nil))

  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))

  (add-hook 'ido-setup-hook 'ido-define-keys))


(when (xorns-configure-p 'experimental)
  (-xorns-customize-ido))


(provide 'xorns-ido)
;;; xorns-ido.el ends here
