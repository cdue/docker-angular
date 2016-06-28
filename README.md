# docker-minimal-node
This is a basic Docker image which allows you to create a dev env for your node or AngularJS projects.
It only contains Node, Git, and a Javascript test suite (Karma, Jasmine, PhantomJS).
Every other libraries must be installed using your project's package.json or bower.json.

For AngularJS purpose, you can use the 'tutorial' below...

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
Or for those experiencing such errors (Windows users for example):
"npm WARN notsup Not compatible with your operating system or architecture: fsevents@1.0.12"
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
$ npm start
```
or
```sh
$ node_modules/http-server/bin/http-server -a 0.0.0.0 -p 8000 -c-1 ./app
```
Windows user: your host port 8000 is binded to container port 8000, but you need to acces the website using your docker machine IP (not localhost).

You can also start the website using default http-server configuration, and without entering a bash terminal into the container:
```sh
$ docker run --rm -it --privileged -v /$(pwd):/app/ -p 8080:8080 "cdue/docker-minimal-node:latest" -c "node_modules/http-server/bin/http-server"
```

## Testing the app:
If you want to be able to run tests with a real browser, you'll need to expose port 9876 (docker run). Then, open a browser at 'http://[127.0.0.1 or docker machine IP]:9876' and run your tests from inside your container.

Otherwise, if you only want to user PhantomJS, just run a bash into your container and run:

```sh
$ npm test
```
or
```sh
$ karma start karma.conf.js
```
