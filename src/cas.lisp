(defpackage :cl-cas
  (:use :cl :alexandria)
  (:nicknames :cas)
  (:export #:cas-login
           #:cas-validate
           #:cas-ticket))

(in-package :cl-cas)

;; https://calnetweb.berkeley.edu/calnet-technologists/cas/how-cas-works

(defun format-url (server-url uri service-url &key suffix)
  (format nil "~A~A?service=~A~@[~A~]" server-url uri service-url suffix))

(defun cas-ticket (query-string)
  "Return the value of the HTTP query-string 'ticket' parameter as CAS Ticket, if exists"
  (cdr (assoc "ticket"
              (quri:url-decode-params query-string)
              :test #'string-equal)))

(defun cas-login (cas-url service-url)
  (format-url cas-url "/login" service-url))

(defun cas-validate (cas-url service-url ticket &key (renew '()))
  "Checks the validity of a service ticket. Return user uid if ticket is valid."
  (let* ((url (format-url cas-url "/validate" service-url
                          :suffix (format nil "&ticket=~a~a" ticket (if renew "&renew=true" ""))))
         (response (babel:octets-to-string (dex:get url :force-binary t))))
    (when (string= (subseq response 0 3) "yes")
      (string-trim '(#\Newline) (subseq response 4)))))

(defun cas-service-validate (cas-url service-url ticket)
  (format-url cas-url "/serviceValidate" service-url))

;; TODO
(defun cas-logout ())

(defun cas-proxy ())

(defun cas-proxy-validate ())

