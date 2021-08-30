;;;; appserver.lisp

(in-package #:appserver)

;;; ---------------------------------------------------------------------
;;; the main HTTP server
;;; ---------------------------------------------------------------------

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

;;; ---------------------------------------------------------------------
;;; the websocket server
;;; ---------------------------------------------------------------------

(defclass chat-room (hunchensocket:websocket-resource)
  ((name :initarg :name :initform (error "Name this room!") :reader name))
  (:default-initargs :client-class 'user))

(defclass user (hunchensocket:websocket-client)
  ((name :initarg :user-agent :reader name :initform (error "Name this user!"))))

(defvar *chat-rooms* (list (make-instance 'chat-room :name "/bongo")
                           (make-instance 'chat-room :name "/fury")))

(defun find-room (request)
  (find (hunchentoot:script-name request) *chat-rooms* :test #'string= :key #'name))

(defun broadcast (room message &rest args)
  (loop for peer in (hunchensocket:clients room)
        do (hunchensocket:send-text-message peer (apply #'format nil message args))))

(defmethod hunchensocket:client-connected ((room chat-room) user)
  (broadcast room "~a has joined ~a" (name user) (name room)))

(defmethod hunchensocket:client-disconnected ((room chat-room) user)
  (broadcast room "~a has left ~a" (name user) (name room)))

(defmethod hunchensocket:text-message-received ((room chat-room) user message)
  (if (equal "/bongo" (name room))
      (broadcast room (format nil "<div id=\"wsresponse\">message received: ~a</div>" message))
      (broadcast room "~a says ~a" (name user) message)))

(defvar *websocket-server* nil)

(defun start-websocket (port)
  (pushnew 'find-room hunchensocket:*websocket-dispatch-table*)
  (setf *websocket-server* (make-instance 'hunchensocket:websocket-acceptor :port port))
  (hunchentoot:start *websocket-server*))

(defun stop-websocket ()
  (hunchentoot:stop *websocket-server*)
  (setf *websocket-server* nil))

;;; ---------------------------------------------------------------------
;;; testing
;;; ---------------------------------------------------------------------

;;; testing the server
;;; (start-server 8000)
;;; (stop-server)

;;; testing websockets
;;; to test:
;;; 1. start the websocket server
;;; 2. open the Chrome websocket test client extension
;;; 3. for the URL, enter ws://localhost:8001/bongo
;;; 4. Type a message into the Request field and click the Send button
;;; Success is when the Message Lof field echoes the text from the Request field
;;; When the websocket server is killed, the websocket connection drops and the client extension's Send button becomes inactive
;;;
;;; (start-websocket 8001)
;;; (stop-websocket)

;;; test the webserver with a websocket
;;; (progn (start-server 8000)(start-websocket 8001))
;;; (progn (stop-server)(stop-websocket))

;;; TODO:
;;; the code in the websocket server section here plus the code
;;; in ui.lisp marked with *** Websocket test manage to open a websocket
;;; and create a web page that connects to it, but there is an error
;;; processing the connection when sending from the form; need to debug and fix
