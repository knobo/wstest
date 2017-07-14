#|
  This file is a part of wstest project.
  Copyright (c) 2017 knobo
|#

#|
  Author: knobo
|#

(in-package :cl-user)
(defpackage wstest-asd
  (:use :cl :asdf))
(in-package :wstest-asd)

(defsystem wstest
  :version "0.1"
  :author "knobo"
  :license ""
  :depends-on (:websocket-driver
               :cl-who
               :lack
               :clack
               :lack-middleware-mount
               :log4cl
	       :jonathan)
  :components ((:module "src"
                :components
                ((:file "wstest"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq))))
