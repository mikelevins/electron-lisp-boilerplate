# electron-lisp-boilerplate

**electron-lisp-boilerplate** is an Electron boilerplate that makes it easy to create an application whose user interface is provided by an Electron application process, and whose application logic is provided by an SBCL server process.

The built application launches the Electron shell, which in turn launches the Lisp server process. The user interface and the server process communicate using HTTP. HTML, CSS, and Javascript assets are built into the Electron application, so that the built application relies on no remote resources to run.


