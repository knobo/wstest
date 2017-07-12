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
Then relaod, and you can see a **"connected"** message in the repl, but no **"disconnect"**.

## Bug 2
When you have fixed Bug 1
in repl:
``` cl
(setf WOO.EV.TCP:*CONNECTION-TIMEOUT* (coerce 5 'double-float))
```
Reload browser, and then again you can see the **"connected"** message, but no **"disconnected"** message

Maybe bug 1, can be fixed by fixing bug 2.

## Bug 3  (upgrade on: "connection" = "keep-alive, Upgrade")
description comes later

For now see:

fukamachi/websocket-driver#24

## Bug 4 (event emitter bug)
description comes later

## Author

* knobo

## Copyright

Copyright (c) 2017 knobo
