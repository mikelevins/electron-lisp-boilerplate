;;; ui.lisp

(in-package #:appserver)

(defun landing-page ()
  (let* ((version (lisp-implementation-version))
         (docroot (cl-user::http-document-root)))
    (with-html-output-to-string (out nil :prologue t)
      (:html
       (:head
        (:link :rel "preconnect" :href "https://cdn.jsdelivr.net")
        (:link :rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/@native-elements/core@1/dist/native-elements.css")
        ;;(:link :rel "stylesheet" :href "css/normalize.css")
        ;;(:link :rel "stylesheet" :href "css/pixal.css")
        ;;(:link :rel "stylesheet" :href "css/fontawesome-all.min.css")
        )
       (:body
        (:script :src "js/htmx.min.js")
        (:div
         (:h2 "Electron Lisp Boilerplate")
         (:p (fmt "Hunchentoot on SBCL v~A" version)))
        (:div
         (:h3 "Document Root")
         (:p (fmt "~A" docroot)))
        (:div
         (:h4 "Send an HTTP request")
         (:form
          (:input :type "text" :name "msg")
          (:br)
          (:button :class "btn"
                   :hx-post "/btnclick"
                   :hx-target "#response"
                   "Send message")))
        (:div :id "response")
        ;; *** Websocket test
        (:div
         (:h4 "Connect to a websocket")
         (:div :id "wsresponse")
         (:div :hx-ws "connect:ws://localhost:8001/bongo"
               (:form :hx-ws "send"
                      (:input :name "message"))))))
      (values))))

