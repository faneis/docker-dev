#!/bin/bash

#Adiciona no crontab a opção para rodar crons a cada 1min
#echo "*       *       *       *       *       run-parts /etc/periodic/1min" >> /etc/crontabs/root

# Iniciamos o server
set -m

# Atualiza o crontab
#crontab -l &

# Ativa o cron
#crond -f -l 8 &

# Ativa o supervisor
#supervisord --configuration=/etc/supervisord.conf &

# Ativa o php
php-fpm

fg %1
