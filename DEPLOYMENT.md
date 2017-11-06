# Deployment

You should first be familiar with the local installation of the website. See [README](./README.md).

### Requirements

The production server runs Debian 9, but you should be able to install the website on any system
as long as you have the following requirements installed:

- [_certbot_](https://certbot.eff.org/)
- [_git_][notes-git]
- [_nginx_][notes-nginx]
- [_php-fpm_ 7][notes-php]
- [_MariaDB_][notes-mariadb]
- [_composer_][notes-composer]
- `mysql` extension for PHP: For Debian, install the `php-mysql` package.

## Create the directory

- Path: `/var/www/tedxinsa.com`

## Create a virtual user

- Username: `tedxinsa.com`
- Home: `/var/www/tedxinsa.com`

```shell
# Run as root
chown -R tedxinsa.com /var/www/tedxinsa.com
```

## Configure MariaDB

Follow the [general MariaDB configuration][notes-mariadb-config] (enable full Unicode support).

## Create the database

**CHANGE THE PASSWORD!!!**

```mysql
CREATE USER 'tedxinsa'@'localhost' IDENTIFIED BY 'password01';
CREATE DATABASE IF NOT EXISTS tedxinsadb;
CREATE DATABASE IF NOT EXISTS tedxinsadb_beta;
GRANT ALL PRIVILEGES ON tedxinsadb.* TO 'tedxinsa'@'localhost';
GRANT ALL PRIVILEGES ON tedxinsadb_beta.* TO 'tedxinsa'@'localhost';
FLUSH PRIVILEGES;
```

## Configure PHP

Check that the following line is enabled in **/etc/php/php.ini**:

```text
extension=mysqli.so
```

## Get a Letsencrypt certificate

[Use Letsencrypt and its Certbot client](https://github.com/demurgos/notes/blob/master/tools/server/letsencrypt/index.md).
Make sure to add the CRON task to auto-renew the certificates.

## Configure _nginx_

[More information](https://github.com/demurgos/notes/blob/master/tools/server/nginx/index.md)

### Set PHP upstream.

Create `/etc/nginx/conf.d/php.nginx`:
```nginx
# Upstream to abstract backend connection for PHP.
# Make sure to include it in the http block of the top nginx.conf
upstream php {
  # `systemctl start php-fpm` on Arch-Linux:
  # Path:
  # - Debian: /var/run/php/php7.0-fpm.sock
  # - Arch Linux: /var/run/php-fpm/php-fpm.sock
  server unix:/var/run/php/php7.0-fpm.sock;
}
```

Edit `/etc/nginx/nginx.conf` and check that `include /etc/nginx/conf.d/*.conf;` is present
in the `http` bloc, before the inclusion of the enabled sites.

### Domain configuration

Create `/etc/nginx/sites-available/tedxinsa.com` and `/etc/nginx/sites-available/beta.tedxinsa.com`
by copying and editing the template [config.nginx](./config.nginx).

Enable the domains:
```
ln -s /etc/nginx/sites-available/tedxinsa.com /etc/nginx/sites-enabled/tedxinsa.com
ln -s /etc/nginx/sites-available/beta.tedxinsa.com /etc/nginx/sites-enabled/beta.tedxinsa.com
systemctl restart nginx
```


## Git clone to `/var/www/tedxinsa.com/beta/`

If you want to use SSH, create a passwordless key.

```shell
# Run as tedxinsa.com
git clone https://github.com/insa-talks/tedxinsa.com.git /var/www/tedxinsa.com/beta/
git clone https://github.com/insa-talks/tedxinsa.com.git /var/www/tedxinsa.com/main/
```

## Configure the environment

Copy the `.env.example` template to `.env` and set `WP_ENV` to `production` and `WP_HOME` to the external URI.

```shell
# Run as tedxinsa.com
cp beta/.env.example beta/.env
cp main/.env.example main/.env
nano beta/.env
nano main/.env
```

## Dependencies

Install the dependencies with composer

```shell
# Run as tedxinsa.com
composer install
```

## Backups

Add a CRON task to regularly run `tools/backup.sh` from the project directory.

## Maintenance

For future updates, just do a git pull and eventually reinstall the Composer dependencies.


[bedrock-home]: https://roots.io/bedrock/
[bedrock-installation]: https://roots.io/bedrock/docs/installing-bedrock/
[github-tedx-theme]: https://github.com/twg/TEDxTheme
[notes-composer]: https://github.com/demurgos/notes/blob/master/tools/languages/php/composer/installation.md
[notes-git]: https://github.com/demurgos/notes/blob/master/tools/development/git/index.md
[notes-mariadb]: https://github.com/demurgos/notes/blob/master/tools/databases/mariadb/index.md
[notes-mariadb-config]: https://github.com/demurgos/notes/blob/master/tools/databases/mariadb/configuration.md
[notes-nginx]: https://github.com/demurgos/notes/blob/master/tools/server/nginx/index.md
[notes-php]: https://github.com/demurgos/notes/blob/master/tools/languages/php/index.md
