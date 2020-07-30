;;; xorns-utils --- Common manipulation utility functions

;; Copyright (C) 2014-2015 Merchise

;; Author: Medardo Rodriguez <med@merchise.org>
;; URL: http://dev.merchise.org/emacs/xorns-utils
;; Keywords: merchise, utilities, convenience
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

;; Extensions functions that can be used in a plain Emacs (with no ELPA
;; extensions installed).  All mode specific functions must be placed
;; in the specific `xorns' sub-module.

;; Enjoy!


;;; Code:


(eval-when-compile
  (require 'cl))


;; TODO: How to auto-load other stuff but functions.

;;;###autoload
(defgroup xorns nil
  "Merchise extensions for Emacs."
  :prefix "xorns-"
  :group 'extensions
  :group 'convenience)



;;; Symbols and variables

;;;###autoload
(defun xorns-get-value (symbol)
  "Return SYMBOL's value or  nil if that is void."
  (if (boundp symbol)
    (symbol-value symbol)))



;;; Strings

;;;###autoload
(defun xorns-str-trim (s)
  "Remove white-spaces at start and end of the string S."
  (let ((blanks split-string-default-separators))
    (replace-regexp-in-string
      (format "\\`%s\\|%s\\'" blanks blanks) "" s)))



;;; Files

(defconst xorns-home-dir
  (purecopy (file-name-as-directory "~"))
  "Home directory.")


(defconst xorns-directory-separator
  (eval-when-compile
    (purecopy
      (char-to-string (elt (file-name-as-directory "x") 1))))
  "Director separator.")


;;;###autoload
(defun xorns-file-path-join (base &rest args)
  "Join BASE and ARGS to a single file path.
The empty string or nil could be used as BASE in order to define root
directory, one of these values at the end make the returned value to have the
final separator."
  (let ((res base))
    (if (or (null res) (equal res ""))
      (setq res xorns-directory-separator))
    (mapc
      (lambda (arg)
	(setq res (concat (file-name-as-directory res) (or arg ""))))
      args)
    res))


;;;###autoload
(defun xorns-preferred-directory (&rest dirs)
  "Return name of preferred directory (the first that exists in DIRS.

If no item is given in DIRS, return $HOME."
  (file-name-as-directory
    (if dirs
      (cl-some
	(lambda (item)
	  (if (and item (file-directory-p item)) item))
	dirs)
      ;; else
      "~")))


;;;###autoload
(defun xorns-preferred-default-directory ()
  "Return name of preferred default directory when start a new session."
  (xorns-preferred-directory
    (getenv "WORKSPACE")
    (xorns-file-path-join "~" "work" "src")
    (xorns-file-path-join "~" "work")
    (xorns-file-path-join "~" "src" "merchise")
    (xorns-file-path-join "~" "src")
    "~"))


;;;###autoload
(defun xorns-locate-emacs-file (&rest args)
  "Return an absolute per-user Emacs-specific file-name.

Find a valid file-name checking each item in ARGS until one if found.  Each
given name is processing with `substitute-in-file-name' to substitute
environment variables referred to in file-name.  The function
`locate-user-emacs-file' is used to localize the file inner Emacs home
folder.  The first file that exists is returned or the last one if not.

Value nil could be part of ARGS in order to use as the last item if it is
desired to force an existing file to be returned.

If no item is given, the name of standard Emacs initialization file is
returned."
  (if args
    (let (res last)
      (while (and (not res) args)
	(let* ((item (car args))
	       (aux
		 (if item
		   (locate-user-emacs-file (substitute-in-file-name item)))))
	  (setq last aux)
	  (if (and aux (file-exists-p aux))
	    (setq res aux)
	    ;; else
	    (setq args (cdr args)))))
      (or res last))
    ;; else
    (locate-user-emacs-file "init.el" ".emacs")))


;;;###autoload
(defun xorns-executable-find (command &rest other-commands)
  "Search for COMMAND in `exec-path' and return the absolute file name.

If COMMAND is not found, looks for alternatives given in OTHER-COMMANDS.

This function is safe avoiding nil commands.  If none is found, nil
is returned."
  (cl-some
    #'(lambda (cmd) (if cmd (executable-find cmd)))
    (push command other-commands)))


;;;###autoload
(defun xorns-default-directory ()
  "Name of default directory of current buffer.

This functions assures that the result always ends with slash and it is
in abbreviated format.  To interactively change the default directory,
use command `cd'."
  (file-name-as-directory (abbreviate-file-name default-directory)))


;;;###autoload
(defun xorns-pwd (&optional no-show)
    "Show and put in the kill ring the current directory.

If optional argument NO-SHOW is not nil, the message is not shown.  The
format for the message is: The first position is used as `<0>' for the
first time this command is executed for each directory, and `<+>' when
repeated; next is printed `$' for an ordinary user or `#' for `root';
then a space and the value of `default-directory'."
    (interactive "P")
    (let* ((pwd (xorns-default-directory))
	   (last (if kill-ring (car kill-ring)))
	   (new (not (equal last pwd)))
	   (sudo (equal user-real-login-name "root"))
	   (prompt (format "%s%s" (if new "<0>" "<+>") (if sudo "#" "$"))))
      (if new
	(kill-new pwd))
      (unless no-show
	(message "%s %s" prompt pwd))))


;; TODO: This code must be removed when every body uses Emacs >= 24.3
(unless (functionp 'file-name-base)
  (defun file-name-base (&optional filename)
     "Return the base name of the FILENAME: no directory, no extension.
FILENAME defaults to `buffer-file-name'."
     (file-name-sans-extension
	(file-name-nondirectory (or filename (buffer-file-name))))))


;; The LOCAL arg to `add-hook' is interpreted differently in Emacs and
;; XEmacs.  In Emacs we don't need to call `make-local-hook' first.
;; It's harmless, though, so the main purpose of this alias is to shut
;; up the byte compiler.
;; This is for "apt-utils" to work.
(unless (functionp 'make-local-hook)
  (defun make-local-hook (hook)
    "Make the hook HOOK local to the current buffer.
The return value is HOOK.

This function is obsolete since 21.1; not necessary any more.

You never need to call this function now that `add-hook' does it for you
if its LOCAL argument is non-nil.

Do not use `make-local-variable' to make a hook variable buffer-local."
    (add-hook hook 'ignore nil 'local)
    hook))



;;; Configuration levels

(defun xorns-get-config-level (arg &optional strict)
  "Transform argument ARG in a valid configuration level.

Value semantics for ARG when STRICT is true are::

- `0', nil or `\'minimum': execute configurations defined as basic or
  implicit.

- `1` or `\'basic': execute minimum extra configurations (including lower
  levels).  These include project management and text modes.

- `1' or `\'general': execute general configurations (including lower
  levels).  These include programming modes.

- `2' or `\'maximum': execute all specific configurations (including lower
  levels).  These include email configuration, and other esoteric stuff.

If STRICT is nil::

- not configured or nil: don't execute specific configurations.

- any other value is synonym of `'maximum'."
  (let ((res
	  (let ((options
		  '((experimental . 110) (110 . 110)
		    (maximum . 100) (100 . 100)
		    (general . 70) (70 . 70)
		    (basic . 10) (10 . 10)
		    (minimum . 0) (nil . 0) (0 . 0)))
		 (default '(t . t)))
	    (cdr (or (assq arg options) default)))))
    (if strict
      (if (not (or (null res) (eq res t)))
	res
	;; else
	(error "Invalid argument `%s' in strict mode!" arg))
      ;; else
      (if (eq res t) 2 res))))


;;;###autoload
(defun xorns-configure-p (&optional arg)
  "Return if a configuration level could be executed.

Optional argument ARG specifies the level to match with the value of
`xorns-config-level' variable; if nil `maximum' is assumed.

Variable `xorns-config-level' only must be defined in the scope of
initialization process (See README file and documentation of
`xorns-get-config-level' function)."
  (let ((conf
	  (xorns-get-config-level
	    (if (boundp 'xorns-config-level)
	      (symbol-value 'xorns-config-level))))
	 (level (xorns-get-config-level arg 'strict)))
    (if conf (<= level conf))))



;;; Features

;;;###autoload
(defun xorns-missing-feature (feature)
  "Report a message about a missing recommended FEATURE."
  (message "Recommended feature `%s' is not installed." feature))


(provide 'xorns-utils)
;;; xorns-utils.el ends here
