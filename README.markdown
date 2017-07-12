# Wstest

## Usage

## Installation
``` sh
ros install knobo/wstest
```

in repl:
``` cl
(ql:qiuckload "wstest")
```

In browser:

http://localhost:5000/

## Bug 1
Then relaod your browser, and you can see a **"connected"** message in the repl, but no **"disconnect"**. There should be a "disconnect" message before the "connected" message.

## Bug 2
When you have fixed Bug 1
in repl:
``` cl
(setf WOO.EV.TCP:*CONNECTION-TIMEOUT* (coerce 5 'double-float))
```
Reload browser, and then again you can see the **"connected"** message, but no **"disconnected"** message

Maybe bug 1, can be fixed by fixing bug 2.

If this is a problem you can do this:

``` cl
(let ((pinger nil))
  (setf pinger (trivial-timers:make-timer (lambda ()
					    (handler-case
						(wsd:send-ping ws nil)
					      (error (e)
						(trivial-timers:unschedule-timer pinger))))))

  (trivial-timers:schedule-timer pinger 20 :repeat-interval 20)
  (wsd:once  :close ws (lambda (&rest args)
			 (trivial-timers:unschedule-timer pinger))))
```

## Bug 3  (upgrade on: "connection" = "keep-alive, Upgrade")
description comes later

For now see:

[fukamachi/websocket-driver#24](https://github.com/fukamachi/websocket-driver/issues/24)


## Bug 4 (event emitter bug)
description comes later

For now see:

[fukamachi/event-emitter#4](https://github.com/fukamachi/event-emitter/issues/4)

## Author

* knobo

## Copyright

Copyright (c) 2017 knobo
