const { app, BrowserWindow, dialog } = require('electron');
//const { spawn } = require('child_process');
const execFile = require('child_process').execFile;
const path = require('path');

const MAIN_URL = 'http://localhost:8000';

function createWindow () {
  // Create the browser window.
  let win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true
    }
  });

  // and load the index.html of the app.
    win.loadURL(MAIN_URL);
}

var lispProcess = null;

function runapp () {
    lispExePath = path.resolve(__dirname, "appserver");
    console.log(lispExePath);
    lispProcess = execFile(lispExePath, [], function(err, stdout, stderr) {
        if(err) {
            console.error(err);
            return;
        }
        console.log("\nFinished.");
    });
    createWindow();
}

function quit() {
    if (lispProcess !== null) {
        lispProcess.kill("SIGKILL");
        lispProcess = null;
    }
    app.exit(0);
}

app.on("ready", runapp);
app.on("quit", quit);
