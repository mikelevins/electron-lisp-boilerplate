#!/bin/sh

sbcl --no-userinit --load lisp/electron-lisp-boilerplate.asd --eval "(cl-user::buildapp)"

# Package
npm i
electron-packager --overwrite . $APP_NAME
cp ./lispapp ./electron-lisp-boilerplate-win32-x64/lispapp.exe
