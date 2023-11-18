;; Define the keywords, types, and built-in functions of Mojo
(defvar mojo-keywords
  '("fn" "struct" "let" "var" "inout" "owned" ""))

(defvar mojo-types
  '("str" "Int" "Float" "Int8" "UInt8" "Int16" "Uint16" "Int32" "UInt32" "Int64" "UInt64" "Float16" "Float32" "Float64" "Bool"))

(defvar mojo-constants
  '("True" "False" "null"))

(defvar mojo-functions
  '("print" "input" "bool" "error" "builtin_list" "builtin_slice" "coroutine" "debug_assert" "dtype" "float_literal" "io" "rebind" "simd" "string_literal" "stringref" "type_aliases" ))

;; Create the regex string for each category of keywords
(defvar mojo-keywords-regexp (regexp-opt mojo-keywords 'words))
(defvar mojo-type-regexp (regexp-opt mojo-types 'words))
(defvar mojo-constant-regexp (regexp-opt mojo-constants 'words))
(defvar mojo-functions-regexp (regexp-opt mojo-functions 'words))

;; Combine the above regexps into a list.
(defvar mojo-font-lock-keywords `((,mojo-type-regexp . font-lock-type-face)
                                  (,mojo-constant-regexp . font-lock-constant-face)
                                  (,mojo-functions-regexp . font-lock-function-name-face)
                                  (,mojo-keywords-regexp . font-lock-keyword-face)))

(defun mojo-compile ()
  "Compile current mojo file."
  (interactive)
    (compile (concat "mojo " buffer-file-name)))

(defvar-keymap mojo-mode-map
  :doc "Keymap for `mojo-mode'."
  "C-c C-c" #'mojo-compile)

;Define the major mode.
(define-derived-mode mojo-mode python-mode "Mojo"
  "Major mode for editing Mojo language code." "mojo mode"
  (font-lock-add-keywords nil mojo-font-lock-keywords 'APPEND)

  ;; Set up the indent function.
  (setq-local indent-line-function 'python-indent-line-function))
  ;; Not yet sure how this should work
  ;; (with-eval-after-load "eglot"
  ;;   (add-to-list 'eglot-stay-out-of 'flymake)))

(defvar mojo-mode-hook nil "Hook for mojo-mode.")

(add-hook 'mojo-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "mojo " buffer-file-name))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.mojo\\'" . mojo-mode))
;; Enable the mode automatically in Python mode, if desired.
;(add-hook 'python-mode-hook 'mojo-mode)

(provide 'mojo-mode)
