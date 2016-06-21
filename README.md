# docker-minimal-node
This is a Docker image based on Alpine. It is lightweight, and I mostly use it to create angularjs project and dev env.
You can use it as you want, and for angular purpose, you can follow the 'tutorial' below...

## Installation:
### Build image
```sh
$ docker build -t "cdue/docker-minimal-node:latest" .
```

## Run a bash:
```sh
$ docker run --rm -it -v $(pwd):/app/ -p 8000:8000 "cdue/docker-minimal-node:latest"
```
Windows users must add a / before $(pwd)

## Create a new angular project
Use angular-seed project template.
See: https://github.com/angular/angular-seed

## Install 3rd party dependencies:
```sh
$ npm install
```
Or for those experiencing error such as "Unsupported dependencies" (Windows users for example):
```sh
$ npm install --no-bin-links
```
Windows users for example will need the --no-bin-links flag to avoid installation problem with fsevents library (which is MacOS specific).
The downside with this flag is that none of npm dependency is added to ./node_modules/.bin which means none will be executable unless you provide its full path...

## Install project dependencies using bower:
```sh
$ bower install --allow-root
```
(using --allow-root because bower doesn't like to run as root, but our container default user is... root)

Or provide full path if you previously used --no-bin-links:
```sh
$ node_modules/bower/bin/bower install --allow-root
```

# Start the website in dev mode:
```sh
$ npm stat
```
or
```sh
$ node_modules/http-server/bin/http-server -a 0.0.0.0 -p 8000 -c-1 ./app
```
Windows user: your host port 8000 is binded to container port 8000, but you need to acces the website using your docker machine IP (not localhost).

## Testing the app:
```sh
$ npm test
```
or
```sh
$ node_modules/karma/bin/karma start karma.conf.js
```
