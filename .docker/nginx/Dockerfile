FROM nginx:1.23.1-alpine

RUN apk update && apk add bash

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/

#Limpa os caches gerados pelas instalações
RUN rm  -rf /tmp/* /var/cache/apk/*
