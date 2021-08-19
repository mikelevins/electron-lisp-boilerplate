;;;; appserver.asd

(in-package :cl-user)

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :hunchentoot-no-ssl *features*))

(ql:quickload :hunchentoot)
(ql:quickload :cl-who)

(asdf:defsystem #:appserver
    :description "Describe appserver here"
  :author "mikel evins <mikel@evins.net>"
  :version "0.0.2"
  :serial t
  :depends-on (:hunchentoot :hunchensocket :cl-who)
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "ui")
                             (:file "appserver")
                             ))))

;;; (asdf:load-system :appserver)
;;; testing the server
;;; (appserver::start-server 8000)
;;; (appserver::stop-server)


(defun http-document-root ()
  (asdf:system-relative-pathname :appserver "../public/"))



(defun appserver-main (&optional (port 8000))
  (funcall (intern "START-SERVER" (find-package :appserver)) port)
  (sb-impl::toplevel-repl nil))

(defun buildapp ()
  (asdf:load-system :appserver)
  (save-lisp-and-die "appserver"
                     :toplevel 'cl-user::appserver-main
                     :executable t))
