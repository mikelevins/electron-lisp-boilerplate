;;;; appserver.lisp

(in-package #:appserver)

(defparameter *server* nil)

(defun start-server (port)
  (setf *server* (make-instance 'hunchentoot:easy-acceptor :port port :document-root (cl-user::http-document-root)))
  (hunchentoot:start *server*))

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (landing-page))

(hunchentoot:define-easy-handler (btnclick :uri "/btnclick") (msg)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Received: ~A" msg))

(defun stop-server ()
  (hunchentoot:stop *server*)
  (setf *server* nil))

;;; testing the server
;;; (start-server 8000)
;;; (stop-server)
