FROM alpine:latest

# Clone the repo
RUN wget -O source.tar.gz https://github.com/zrrrzzt/tfk-api-unoconv/archive/3.2.5.tar.gz
RUN tar xf source.tar.gz && mv tfk-api-unoconv* /unoconvservice && ls /unoconvservice
RUN apk add --update nodejs npm
RUN apk --no-cache add bash mc \
            curl \
            util-linux \
            libreoffice-common \
            libreoffice-calc \
            libreoffice-draw \
            libreoffice-impress \
            libreoffice-writer \
            ttf-droid-nonlatin \
            ttf-droid \
            ttf-dejavu \
            ttf-freefont \
            ttf-liberation
RUN apk --no-cache add make git python3

RUN wget -O source.tar.gz https://github.com/unoconv/unoconv/archive/0.8.2.tar.gz && tar xf source.tar.gz && cd unoconv-0.8.2 && make install
# Change working directory
WORKDIR /unoconvservice

# Install dependencies
RUN npm install --production && ln -s $(which python3) /usr/bin/python

# Env variables
ENV SERVER_PORT 3000
ENV PAYLOAD_MAX_SIZE 10485760
ENV TIMEOUT_SERVER 120000
ENV TIMEOUT_SOCKET 140000

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 & node standalone.js
