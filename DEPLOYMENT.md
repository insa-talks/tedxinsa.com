# Deployment

## Requirements

- nginx
- mariadb
- php-fpm
- git

## Create the directory

- Path: `/var/www/tedxinsa.com`

## Create a virtual user

- Username: `tedxinsa.com`
- Home: `/var/www/tedxinsa.com`

```shell
# Run as root
chown -R tedxinsa.com /var/www/tedxinsa.com
```

## Create the database

## Get a Letsencrypt certificate

## Configure PHP

## Configure _nginx_

Set PHP upstream and add a PHP configuration for each domain.

## Configure MariaDB

**CHANGE THE PASSWORD!!!**

```mysql
CREATE USER 'tedxinsa'@'localhost' IDENTIFIED BY 'password01';
CREATE DATABASE IF NOT EXISTS tedxinsadb;
CREATE DATABASE IF NOT EXISTS tedxinsadb_beta;
GRANT ALL PRIVILEGES ON tedxinsadb.* TO 'tedxinsa'@'localhost';
GRANT ALL PRIVILEGES ON tedxinsadb_beta.* TO 'tedxinsa'@'localhost';
FLUSH PRIVILEGES;
```

## Git clone to `/var/www/tedxinsa.com/beta/`

If you want to use SSH, create a passwordless key.

```shell
# Run as tedxinsa.com
git clone https://github.com/insa-talks/tedxinsa.com.git /var/www/tedxinsa.com/beta/
```

## Set `.env`

```shell
# Run as tedxinsa.com
cd beta
cp .env.example .env
nano .env
```
