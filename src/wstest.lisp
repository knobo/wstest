(in-package :cl-user)
(defpackage wstest
  (:use :cl :websocket-driver :cl-who :lack))
(in-package :wstest)

(defparameter *echo-server*
  (lambda (env)
    (let ((ws (make-server env)))
      (log:info "Connected")
      (on :message ws
	  (lambda (message)
	    (log:info 'message message)
	    (send ws message)))
      (on :close ws (lambda (&rest args)
		      (log:info "Closed" args)))
      (on :error ws (lambda (&rest args)
		      (log:info "Error" args)))
      (on :open ws (lambda (&rest args)
		     (log:info "Open" args)))
      (lambda (responder)
	(declare (ignore responder))
	(start-connection ws)))))

(setf (html-mode) :html5)

(defvar *server* nil)
(defparameter *web* (lack:builder
		     :session
		     :backtrace
		     (:mount "/echo" *echo-server*)
		     (lambda (env)
		       (declare (ignore env))
		       `(200 () (, (with-html-output-to-string (s nil :prologue t :indent t)
				     (:html
				      (:head
				       (:script :src "https://code.jquery.com/jquery-3.2.1.slim.min.js"))
				      (:body
				       (:h1 "Websocket Test")
				       (:button :class "send" "Send")
				       (:div :class "msg")
				       (:script "
$(function () {
  var connect = function () {
    var ws = new WebSocket('ws://localhost:5000/echo');
    $('.send').click(function (){
      console.log('clicked');
      ws.send(JSON.stringify({message:'Hi'}));
    });
    ws.onmessage = function(event) {
      console.log('Message', event.data);
      var f = $('.msg');
      var msg = JSON.parse(event.data);
      var tmpl = `<div> ${msg.message} </div>`;
      f.append(tmpl);
    };
    ws.onclose = function (e){
      setTimeout(function(){
	console.log('WebSocket: reconnecting...');
	connect();
      },1000);
    };
  };

    connect();
});
")))))))))


(defun start ()
  (setf *server* (clack:clackup *web*
				:server :woo :port 5000)))

(defun stop ()
  (clack:stop *server*))

(ignore-errors (stop))
(start)
