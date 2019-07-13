;; Log a message
(message "hi")

;; Standard arithmetic
(+ 1 2)

;; Use let to define temporary, local variables
(let ((something "test"))
  (message something))

;; Use let* does the same, but permits previously defined variables to be used in newly defined variables
(let* ((var1 "value1")
       (var2 (concat var1 "value2")))
  (message var2))

;; Run multiple expressions in sequence
(progn
  (message "1")
  (message "2"))

;; To set a variable
(setq test-var "test-var-value")
(message test-var)

;; Function definition
(defun test-fn (param)
  (message param))
(test-fn "hello again")

(defun test-fn-2 ()
  (interactive) ;; Makes the function callable in Emacs, via M-x <function name>
  (message "hello thar"))

;; To assign a function to a specific keybinding
(define-key emacs-lisp-mode-map (kbd "C-c M-y C-a") 'test-fn-2)

;; Gets the contents of the buffer
(message (buffer-string))

;; Sets the current buffer without switching to it
(set-buffer (current-buffer))

;; Sets the current buffer and switches to it
;; (switch-to-buffer "test.txt")

;; major-mode is an example of a buffer-local variable
;; Note: the symbol-name function converts a symbol to a string (https://emacsredux.com/blog/2014/12/05/converting-between-symbols-and-strings/)
(message (symbol-name major-mode))

;; To define local variables, scoped to a specific buffer, use defvar, then make-local-variable
(defvar buffer-local-variable-test nil "docstring")
(set (make-local-variable 'buffer-local-variable-test)
     "test value") ;; (Executed later, in the given buffer)
(message buffer-local-variable-test)

;; The current 'point' is where the cursor is. The min and max points are the bounds of the buffer
(message (buffer-substring (point-min)
                           (point-max)))

;; Use region-beginning/end to get the points which bound the user-selected region in the buffer
(defun test-fn-3 ()
  (interactive)
  (message (buffer-substring (region-beginning)
                             (region-end))))

;; Insert text at point
(defun test-fn-4 ()
  (interactive)
  (insert "test-string"))

(defun test-fn-5 ()
  (interactive)
  (delete-region (region-beginning)
                 (region-end)))

;; Manipulating text properties
(message (propertize "test" 'face 'bold-italic))

;; There are functions which can manipulate the position of the cursor
(defvar point-a nil)
(defvar point-b nil)
(defun test-fn-6 ()
  (interactive)
  (beginning-of-line)
  (set (make-local-variable 'point-a)
       (point))
  (end-of-line)
  (set (make-local-variable 'point-b)
       (point))
  (delete-region point-a point-b))
(defun test-fn-7 ()
  (interactive)
  (search-forward-regexp "^test"))

;; To save/restore the original cursor position before changing it
(defun test-fn-8 ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (looking-at "abc")
        (message "line starts with abc")
      (message "line doesn't start with abc"))))

;; You can use a temporary buffer to do stuff, without modifying the current buffer
(defun test-fn-9 ()
  (interactive)
  (with-temp-buffer
    (insert "test-string")
    (save-excursion
      (beginning-of-line)
      (if (looking-at "test-string")
          (message "line in temp buffer matches")
        (message "line in temp buffer doesn't match")))))

;; To define a new major mode
(define-derived-mode test-mode
  text-mode
  "Test"
  (setq case-fold-search nil))
(define-key test-mode-map (kbd "C-c M-y C-b") 'test-fn-2)

;; To define a new minor mode
(defvar test-minor-mode-map (make-sparse-keymap))
(define-minor-mode test-minor-mode
  "Test minor"
  :keymap test-minor-mode-map
  (if (bound-and-true-p test-minor-mode)
      (message "Test minor mode active")
    (message "Test minor mode not active")))
(define-key test-minor-mode-map (kbd "C-c M-y C-c") 'test-fn-2)
