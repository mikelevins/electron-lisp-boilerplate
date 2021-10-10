#!/bin/sh

#/c/acl10.1.64/alisp --qq -L lisp/appserver.asd -e "(cl-user::buildapp)" --kill

/c/Program\ Files/Steel\ Bank\ Common\ Lisp/2.0.0/sbcl.exe --dynamic-space-size 4gb --no-userinit --load lisp/appserver.asd --eval "(cl-user::buildapp)"

# test command that leaves ACL console windows up for debugging purposes:
#  /c/acl10.1.64/alisp -p --qq -L lisp/appserver.asd -e "(cl-user::buildapp)"

# Package
npm i
npx electron-packager . electron-lisp-boilerplate --overwrite
