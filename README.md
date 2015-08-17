# Blueprint Writing Toolkit

This repo contains build automation for the writing toolkit.

The writing toolkit source code itself is inside of the `app/`
folder.

### /app

The app uses webpack to serve a react.js app, which uses semantic-ui
as a CSS / UI Framework.

The app is delivered via the electron framework.

The application entry point is `src/browser/main.coffee`

##### Settings

- `BRIEF_BIN_PATH`: the path to the `brief` executable.
- `DATAPIMP_BIN_PATH`: the path to the `datapimp` executable.
- `BRIEF_HOME_PATH`: where your brief configuration is housed. `~/.brief`

### Electron

Electron has two processes: the main process, and the renderer
process.  The main process is a standard node.js process.  The
renderer process is a chromium based browser javascript environment.

Electron provides ways of communicating between the two processes.

Most of the magic happens in the browser based codebase.  

Some things, however, are happening in the main process, namely,
the `brief` process which is a ruby library runs on a socket.  In
addition to this, the webpack development server runs so that we
can live edit the css & javascript code.

You will find this code in the `app/src/browser` folder.

### The React App

The React app can be found in the `app/src/renderer` folder.

The React app uses webpack, and its loader system, to power a
system of react components written in CJSX -- which is a
coffeescript variant of JSX.

### React App Structure

- Router
  - Pages
    - Layout / Components

- SVGAnimatorAdapter
