FROM debian:wheezy

MAINTAINER david [at] byng [dot] co
# no that isn't a typo

# Install basics 
RUN apt-get update &&  \
    apt-get install -y git wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get update &&  \
    apt-get install -y nodejs nodejs-legacy build-essential && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install npm packages
RUN npm install -g cordova ionic grunt-cli gulp bower

RUN ionic start ionic-demo sidemenu

# Expose port: web (8100), livereload (35729)
EXPOSE 8100 35729

WORKDIR ionic-demo
CMD ["ionic", "serve", "--port", "8100", "--livereload-port", "35729", "--all", "--no-browser"]
