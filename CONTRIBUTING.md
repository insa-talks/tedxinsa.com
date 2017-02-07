# Contributing

## Requirements

- [_nginx_][notes-nginx]
- [_php-fpm_ 7][notes-php]
- [_MariaDB_][notes-mariadb]
- [_composer_][notes-composer]

### PHP extensions

- mysql (`php-mysql` for Debian)

## Create a MariaDB database

- MariaDB user: `tedxinsa`
- MariaDB database: `tedxinsadb`
- MariaDB port: 3306
- MariaDB host: localhost

```terminal
MariaDB [(none)]> CREATE USER 'tedxinsa'@'localhost' IDENTIFIED BY '1234';
Query OK, 0 rows affected (0.10 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS tedxinsadb;
Query OK, 1 row affected (0.04 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON tedxinsadb.* TO 'tedxinsa'@'localhost';
Query OK, 0 rows affected (0.04 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.04 sec)

```

## Configure **.env**

Copy the file **.env.example** to **.env**:

```text
# Possible values: development production
WP_ENV=development
# Set the external URI of the root of the website
WP_HOME=https://tedxinsa.localhost
# Do not edit the following value (used internally)
WP_SITEURL=${WP_HOME}/wp
```

## Install dependencies

```shell
# Run as a normal user
composer install
```

## Configure PHP

Check that the following line is uncommented in **/etc/php/php.ini**:

```text
extension=mysqli.so
```

## Run

```shell
# Run as root
systemctl start nginx
systemctl start php-fpm
systemctl start mariadb
```

## Wordpress Installation

### Step 0

- Select a default language
  - Choose `Français`

### Step 1

- Titre du site
  - `TEDxINSA`: Check the capitalization
- Identifiant
  - `admintedxinsa`: DO NOT USE YOUR PERSONAL ACCOUNT!
- Mot de passe
  - Generate and store it with Keeweb to the association's passwords file
- Adresse de messagerie:
  - `webmaster@tedxinsa.com`
- Visibilité pour les moteurs de recherche
  - **Keep the default** (unchecked)

### Step 2

- In the administration panel, choose the TEDx theme.

## References

- https://roots.io/bedrock/docs/installing-bedrock/

[notes-composer]: https://github.com/demurgos/notes/blob/master/tools/languages/php/composer/installation.md
[notes-mariadb]: https://github.com/demurgos/notes/blob/master/tools/databases/mariadb/index.md
[notes-nginx]: https://github.com/demurgos/notes/blob/master/tools/server/nginx/index.md
[notes-php]: https://github.com/demurgos/notes/blob/master/tools/languages/php/index.md
