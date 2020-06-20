;;;; electron-lisp-boilerplate.asd

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(asdf:defsystem #:electron-lisp-boilerplate
  :description "Describe electron-lisp-boilerplate here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot :cl-who)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "electron-lisp-boilerplate")))))

;;; (asdf:load-system :electron-lisp-boilerplate)

(defun buildapp ()
  (asdf:load-system :electron-lisp-boilerplate)
  (save-lisp-and-die "lispapp"
                     :toplevel 'cl-user::main
                     :executable t))

