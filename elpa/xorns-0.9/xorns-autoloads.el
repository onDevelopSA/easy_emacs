;;; xorns-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "xorns-all" "xorns-all.el" (22722 52586 477962
;;;;;;  81000))
;;; Generated autoloads from xorns-all.el

(autoload 'xorns-all-dependencies-install "xorns-all" "\
Install all dependencies of text modes.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "xorns-buffers" "xorns-buffers.el" (22722 52586
;;;;;;  477962 81000))
;;; Generated autoloads from xorns-buffers.el

(autoload 'xorns-force-scratch "xorns-buffers" "\
Switch to `*scratch*` buffer, creating a new one if needed.

An optional argument ARG could be given to delete other windows; if
`0' also reset `default-directory' to `xorns' default.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "xorns-dired" "xorns-dired.el" (22722 52586
;;;;;;  477962 81000))
;;; Generated autoloads from xorns-dired.el

(autoload 'xorns-dired-single-buffer "xorns-dired" "\
Visit selected directory in current buffer.
Improve default `dired-single-buffer' by remembering parent position for
recovering it when navigating up.

Optional argument DEFAULT-DIRNAME specifies the directory to visit; if not
specified, the directory or file on the current line is used (assuming it's a
dired buffer).  If the current line represents a file, the file is visited in
another window.

\(fn &optional DEFAULT-DIRNAME)" t nil)

;;;***

;;;### (autoloads nil "xorns-git" "xorns-git.el" (22722 52586 477962
;;;;;;  81000))
;;; Generated autoloads from xorns-git.el

(autoload 'xorns-git-dependencies-install "xorns-git" "\
Install all dependencies for `git' modes.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "xorns-package" "xorns-package.el" (22722 52586
;;;;;;  477962 81000))
;;; Generated autoloads from xorns-package.el

(autoload 'xorns-dependency-install "xorns-package" "\
Install a dependency FEATURE if not installed.

\(fn FEATURE)" nil nil)

;;;***

;;;### (autoloads nil "xorns-prog" "xorns-prog.el" (22722 52586 477962
;;;;;;  81000))
;;; Generated autoloads from xorns-prog.el

(autoload 'xorns-python-shell-send-cpaste "xorns-prog" "\
Send the region delimited by START and END wrapped with a %cpaste magic.

\(fn START END)" t nil)

(autoload 'xorns-jedi-setup "xorns-prog" "\
Setup `jedi' for current buffer.

\(fn)" nil nil)

(autoload 'xorns-prog-dependencies-install "xorns-prog" "\
Install all dependencies of text modes.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "xorns-term" "xorns-term.el" (22722 52586 477962
;;;;;;  81000))
;;; Generated autoloads from xorns-term.el

(autoload 'xorns-ansi-term "xorns-term" "\
Start a terminal-emulator in a new buffer.

The meaning of optional argument ARG depends of `major-mode' value.
Non nil means alternative shell, if `major-mode' is not `python-mode'
*base* is a system shell and *alternative* is a python shell;
otherwise the logic is inverted.  If ARG is number `3' (independently
of `major-mode') try to run a `python-3' shell if installed.

The base shell to execute is defined in the custom variable
`xorns-base-shell'; if it is nil, use the function
`xorns-default-shell'.

The python shell to execute is defined in the custom variable
`xorns-python-shell'; if it is nil, use the function
`xorns-default-python-shell'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "xorns-text" "xorns-text.el" (22722 52586 477962
;;;;;;  81000))
;;; Generated autoloads from xorns-text.el

(autoload 'xorns-text-dependencies-install "xorns-text" "\
Install all dependencies of text modes.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil "xorns-utils" "xorns-utils.el" (22722 52586
;;;;;;  477962 81000))
;;; Generated autoloads from xorns-utils.el

(let ((loads (get 'xorns 'custom-loads))) (if (member '"xorns-utils" loads) nil (put 'xorns 'custom-loads (cons '"xorns-utils" loads))))

(autoload 'xorns-get-value "xorns-utils" "\
Return SYMBOL's value or  nil if that is void.

\(fn SYMBOL)" nil nil)

(autoload 'xorns-str-trim "xorns-utils" "\
Remove white-spaces at start and end of the string S.

\(fn S)" nil nil)

(autoload 'xorns-file-path-join "xorns-utils" "\
Join BASE and ARGS to a single file path.
The empty string or nil could be used as BASE in order to define root
directory, one of these values at the end make the returned value to have the
final separator.

\(fn BASE &rest ARGS)" nil nil)

(autoload 'xorns-preferred-directory "xorns-utils" "\
Return name of preferred directory (the first that exists in DIRS.

If no item is given in DIRS, return $HOME.

\(fn &rest DIRS)" nil nil)

(autoload 'xorns-preferred-default-directory "xorns-utils" "\
Return name of preferred default directory when start a new session.

\(fn)" nil nil)

(autoload 'xorns-locate-emacs-file "xorns-utils" "\
Return an absolute per-user Emacs-specific file-name.

Find a valid file-name checking each item in ARGS until one if found.  Each
given name is processing with `substitute-in-file-name' to substitute
environment variables referred to in file-name.  The function
`locate-user-emacs-file' is used to localize the file inner Emacs home
folder.  The first file that exists is returned or the last one if not.

Value nil could be part of ARGS in order to use as the last item if it is
desired to force an existing file to be returned.

If no item is given, the name of standard Emacs initialization file is
returned.

\(fn &rest ARGS)" nil nil)

(autoload 'xorns-executable-find "xorns-utils" "\
Search for COMMAND in `exec-path' and return the absolute file name.

If COMMAND is not found, looks for alternatives given in OTHER-COMMANDS.

This function is safe avoiding nil commands.  If none is found, nil
is returned.

\(fn COMMAND &rest OTHER-COMMANDS)" nil nil)

(autoload 'xorns-default-directory "xorns-utils" "\
Name of default directory of current buffer.

This functions assures that the result always ends with slash and it is
in abbreviated format.  To interactively change the default directory,
use command `cd'.

\(fn)" nil nil)

(autoload 'xorns-pwd "xorns-utils" "\
Show and put in the kill ring the current directory.

If optional argument NO-SHOW is not nil, the message is not shown.  The
format for the message is: The first position is used as `<0>' for the
first time this command is executed for each directory, and `<+>' when
repeated; next is printed `$' for an ordinary user or `#' for `root';
then a space and the value of `default-directory'.

\(fn &optional NO-SHOW)" t nil)

(autoload 'xorns-configure-p "xorns-utils" "\
Return if a configuration level could be executed.

Optional argument ARG specifies the level to match with the value of
`xorns-config-level' variable; if nil `maximum' is assumed.

Variable `xorns-config-level' only must be defined in the scope of
initialization process (See README file and documentation of
`xorns-get-config-level' function).

\(fn &optional ARG)" nil nil)

(autoload 'xorns-missing-feature "xorns-utils" "\
Report a message about a missing recommended FEATURE.

\(fn FEATURE)" nil nil)

;;;***

;;;### (autoloads nil nil ("xorns-extra.el" "xorns-frames.el" "xorns-gud.el"
;;;;;;  "xorns-ido.el" "xorns-mail.el" "xorns-org.el" "xorns-pkg.el"
;;;;;;  "xorns-project.el" "xorns-simple.el" "xorns-startup.el" "xorns-widgets.el"
;;;;;;  "xorns.el") (22722 52586 498956 342000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; xorns-autoloads.el ends here
