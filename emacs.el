
; Este es el que me pone las lineas en la identacioon.
(load "~/.emacs.d/elpa/highlight_indent/highlight_indent.el")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-character ?\|)
(setq highlight-indent-guides-auto-even-face-perc 18)

; Este me sirve para resaltar las palabras donde se ubica el puntero
; lo que no me gusta es el colorcito pero lo voy a cambiar.
(load "~/.emacs.d/elpa/idle_highlight/idle_highlight.el")
(require 'idle-highlight-in-visible-buffers-mode)
;; Optional
;(set-face-attribute 'idle-highlight-in-visible-buffers nil :foreground "SpringGreen3" :weight 'bold)/
(add-hook 'prog-mode-hook 'idle-highlight-in-visible-buffers-mode)

;; Estas dos de abajo con las combinaciones de teclas son para mover una
;; linea para arriba o para abajo.
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

;; Esto es para sustituir yes-no cuando tengo que confirmar algo por ejemplo
;; eliminar una carpeta , etc y usar y-n en su lugar.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Esto es para quitar la barra de menu y la de herramientas.
(tool-bar-mode -1)
(menu-bar-mode 0)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-c r") 'rgrep);
(global-set-key (kbd "M-p") 'dired-jump) ; Ctrl+x p
(global-set-key (kbd "C-x g") 'magit-status) ; Ctrl+x g   ... para el magit

;; este es para bajar un poco el tamanno de la fuente.
(set-face-attribute 'default nil :height 105)

;; Estos dos abajo son para dividir la pantalla horizontalmente
(setq split-with-threshold 0)
(setq split-height-threshold nil)


;; este es para que se coloreen las lineas de un gris agradable a la
;; vista cuando pasen de 80 caracteres.
;; (custom-set-faces
;;    '(my-tab-face            ((((class color)) (:background "white smoke"))) t)
;;    '(my-trailing-space-face ((((class color)) (:background "white smoke"))) t)
;;    '(my-long-line-face ((((class color)) (:background "white smoke"))) t))

;; (add-hook 'font-lock-mode-hook
;;             (function
;;              (lambda ()
;;                (setq font-lock-keywords
;;                      (append font-lock-keywords
;;                              '(("\t+" (0 'my-tab-face t))
;;                                ("^.\\{81,\\}$" (0 'my-long-line-face t))
;;                                ("[ \t]+$"      (0 'my-trailing-space-face t))))))))

;;-------------------------------------------------------------------------
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))


;;-------------------------------------------------------------------------
;; (global-set-key [?\C-c ?d] 'duplicate-line-or-region)
(global-set-key (kbd "C-d") 'duplicate-line-or-region)

;;-------------------------------------------------------------------------

; Esto es para que cuando de copiar se ponga por defecto la carpeta del otro dir 
(setq dired-dwim-target t)

;Estas son tres variantes para llevar el código a 79 carateres las lineas de
;código la primera me pone una linea en la cabecera y la segunda hay que
;activarla con M-x prog-mode , la tercera hay que activarla tambien con
;‘C-u 70 M-x column-marker-2’

;variante 1
(setq-default header-line-format 
              (list " " (make-string 79 ?-) "|"))

;variante 2     
; (setq-default
;  whitespace-line-column 80
;  whitespace-style       '(face lines-tail))
; (add-hook 'prog-mode-hook #'whitespace-mode)

; (load "~/.emacs.d/elpa/column-marker/column-marker.el")

;Este es el modo para los mostrar los números en las lineas 
(global-linum-mode 1)
;Este me permite cuando seleccione un texto y pegue otro encima
;se sobreescriba el de abajo que por defecto no lo tiene.
(delete-selection-mode 1)

;Este muestra las opciones para completar por ejemplo en el dir.
(icomplete-mode 1)

;Esto me define el modo abreviatura por defecto para completar
;con un trozo de código por ejemplo el comentario.
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table
  '(
    ("tod" "'''TODO:DOCUMENT'''")
    ("coco" "# Comment")
    ("ass" "assert False, 'cabeza en la acera ..'")
    ("ipdb" "import ipdb; ipdb.set_trace() # REMOVE THIS" nil 2)
    ("pdb" "import pdb; pdb.set_trace() # REMOVE THIS" nil 2)
    ("ppp" "print('*****************'* 20)# REMOVE THIS" nil 2)
    ("ddd" "%Y-%m-%d %H:%M:%S" nil 2)
    ("cclass" "class AccountMove(models.Model): \n _inherit = 'account.move' \n   @api.model\n   def create(self, vals):\n   '''TODO:DOCUMENT'''\n   import ipdb; ipdb.set_trace() # REMOVE THIS\n   assert False, 'cabeza en la acera ..'\n   return super(AccountMove, self).create(vals) " nil 2)
    ("ccrea" " @api.model \n def create(self, vals): \n '''TODO:DOCUMENT \n''' \n          return super(, self).create(vals) " nil 2)
    ("cwrite" " @api.multi \n def write(self, vals): \n '''TODO:DOCUMENT \n''' \n
     return super(, self).write(vals) " nil 2)
   ))

;Esto es para que por defecto me salga maximizada la ventana.
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;(add-to-list 'load-path "~/.emacs.d/elpa/magit-master/lisp")
;(let ((default-directory  "~/.emacs.d/elpa/magit-20170214.347"))
;  (normal-top-level-add-subdirs-to-load-path))
;(load "~/.emacs.d/elpa/magit-master/lisp")

(load "~/.emacs.d/elpa/word-count-mode-master/word-count.el")

;; (add-hook 'latex-mode-hook (lambda () (auto-fill-mode -1)))

;; (define-minor-mode line-mode
;;   "some stuf"
;;    (function
;;              (lambda ()
;;                (setq font-lock-keywords
;;                      (append font-lock-keywords
;;                              '(("\t+" (0 'my-tab-face t))
;;                                ("^.\\{80,\\}$" (0 'my-long-line-face t))
;;                                ("[ \t]+$"      (0 'my-trailing-space-face t)))))))
;;   )


;; (custom-set-faces
;;  '(my-tab-face            ((((class color)) (:background "white"))) t)
;;  '(my-trailing-space-face ((((class color)) (:background "white"))) t)
;;  '(my-long-line-face ((((class color)) (:background "white smoke"))) t))

;; (add-hook 'font-lock-mode-hook
;;             (function
;;              (lambda ()
;;                (setq font-lock-keywords
;;                      (append font-lock-keywords
;;                              '(("\t+" (0 'my-tab-face t))
;;                                ("^.\\{80,\\}$" (0 'my-long-line-face t))
;;                                ("[ \t]+$"      (0 'my-trailing-space-face t))))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
