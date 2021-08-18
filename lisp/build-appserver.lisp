(in-package :cl-user)

(require :asdf)
#+darwin
(load "/Users/mikel/Workshop/src/lisp/electron-lisp-boilerplate-2/lisp/appserver.asd")
#+linux
(load "/home/mikel/Workshop/src/lisp/electron-lisp-boilerplate-2/lisp/appserver.asd")
#+os-windows
(load "c:/electron-lisp-boilerplate-2/lisp/appserver.asd")
(asdf:load-system :appserver)

(defun cl-user::http-document-root ()
  (let* ((command-line-args (SYS:COMMAND-LINE-ARGUMENTS))
         (lisp-path (first command-line-args))
         (lisp-directory-path (ASDF/PATHNAME:PATHNAME-DIRECTORY-PATHNAME lisp-path)))
    (merge-pathnames "../public/" lisp-directory-path)))

;;; (cl-user::http-document-root)

