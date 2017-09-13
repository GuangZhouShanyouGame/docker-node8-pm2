FROM node:8-alpine
MAINTAINER Yhl, qingwen.ye@1024hw.org
ENV NODE_ENV production
ENV TIMEZONE Asia/Shanghai
RUN mkdir -p /app
WORKDIR /app
RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    npm install pm2 -g && \
    npm cache clean -f && \
    npm config set registry https://registry.npm.taobao.org && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

CMD pm2-docker start npm -- start