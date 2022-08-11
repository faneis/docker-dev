# Docker para desenvolvimento
NGINX 1.23 + PHP 8.1 + Mysql 5.7 | Testado usando WLS Ubuntu
Esse docker foi criado para desenvolver aplicações usando o Framework Laravel

## Pasta .docker
Os arquivos do docker estão todos na pasta .docker, portanto essa pasta pode ser adicionada em qualquer projeto que você precise utilizar o docker para desenvolvimento

## Pasta .docker/php
Configuração atual está com PHP 8.1, se for necessário trocar basta substituir o arquivo Dockerfile desta pasta

  - uploads.ini serve para ajustar algumas diretivas do PHP, após mudar é necessário fazer a build novamente
  - entrypoint.sh serve para inicializar o php e se precisar ativar crons é só descomentar a linha "crontab -l &" e "crond -f -l 8 &"
    - Se for usar os crons, também é necessário descomentar as linhas "# Adiciona o cron do schedule" do Dockerfile, este irá copiar o comando que executará o schedule:run do Laravel via cron
    - Se precisar mudar o tempo de executação é só substituir a pasta do cron que está sendo enviado o arquivo

## Pasta .docker/nginx
Configuração atual está com NGINX 1.23, se for necessário trocar basta substituir o arquivo Dockerfile desta pasta

  - nginx.conf serve para configurar o serviço http

## Pasta public
Nginx irá executar o que estiver dentro dessa pasta.

## Docker Compose
Executa os containers para reconhecer o diretório em que este arquivo estiver, dessa forma é possível desenvolver local enquanto roda o container sem a necessidade de conectar remoto.

Está configurado com os seguintes serviços:
  - nginx - porta 8000
  - php (acesso ocorre pelo nginx via porta 8000)
  - mysql - porta 3306
  - adminer - porta 8080

> Importante ajustar as linhas MYSQL_DATABASE e MYSQL_ROOT_PASSWORD do docker-compose.yml para refletir com o que você está fazendo
>
> A conexão ao MySQL deve ser feita utilizando o nome do conteiner (*mysql*) e não (*localhost*)

## Executar
Após executar esse comando deve liberar ao endereço localhost:8000

```
docker-compose up -d
```

## Parar
```
docker-compose down -v
```

## Build
```
docker-compose build
```