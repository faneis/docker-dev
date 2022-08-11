FROM php:8.1.9-fpm-alpine3.16

# Cria um usuário com as mesmas credencias de acesso da maquina local
RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

# Configura o Linux
RUN apk add --no-cache \
  # Default
  openssl bash nodejs npm alpine-sdk autoconf tzdata oniguruma-dev \
  # Compression
  zstd-dev \
  # Configurações extras do GD e ZIP para o PHP
  freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
  libxml2-dev libzip-dev && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install -j${NPROC} gd zip && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev

# Configura o timezone
RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" > /etc/timezone
RUN apk del tzdata

# Configura o PHP
RUN docker-php-ext-install pdo pdo_mysql bcmath soap mbstring
# RUN no | pecl install redis && docker-php-ext-enable redis

# Adiciona supervisor para as queues
# RUN apk add supervisor

WORKDIR /var/www

RUN rm -rf /var/www/html

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Cria o diretório para rodar crons por minuto
# RUN mkdir /etc/periodic/1min

# Adiciona o cron do schedule
# COPY cron/artisan_schedule /etc/periodic/15min/
# RUN chmod a+x /etc/periodic/15min/artisan_schedule

# Adiciona o composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Limpa os caches gerados pelas instalações
RUN rm  -rf /tmp/* /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]