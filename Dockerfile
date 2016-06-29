FROM ubuntu:16.04
MAINTAINER Cédric Dué "cedric.due@gmail.com"

# install Node & Git
RUN apt-get update && apt-get install -y \
  git \
  git-core \
  nodejs \
  npm \
  libfontconfig \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Create a symlink for nodejs
RUN ln -s /usr/bin/nodejs /usr/bin/node

# installing Karma, Jasmine and PhantomJS as a global dependencies
RUN npm install -g jasmine-core phantomjs-prebuilt karma karma-phantomjs-launcher karma-jasmine karma-junit-reporter

WORKDIR /app

EXPOSE 8000
EXPOSE 9876

#
# start a bash terminal
#
ENTRYPOINT ["/bin/bash"]
