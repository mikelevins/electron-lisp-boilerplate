#!/bin/sh

sbcl --no-userinit --load lisp/appserver.asd --eval "(cl-user::buildapp)"

# Package
npm i
npx electron-packager . electron-lisp-boilerplate --overwrite
