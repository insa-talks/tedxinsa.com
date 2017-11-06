# tedxinsa.com

Code source for the [TEDxINSA](https://tedxinsa.com/) website.
The website uses the Wordpress PHP framework with a theme based off [twg/TEDxTheme][github-tedx-theme].
It follows modern Wordpress practices by using [Bedrock][bedrock-home] and [Composer].

## Installation

This section describes how to install the website locally.

**References**
- [Bedrock installation][bedrock-installation]

### Requirements

The production server runs Debian 9, but you should be able to install the website on any system
as long as you have the following requirements installed:

- [_nginx_][notes-nginx] (optional)
- [_php-fpm_ 7][notes-php]
- [_MariaDB_][notes-mariadb]
- [_composer_][notes-composer]
- `mysql` extension for PHP: For Debian, install the `php-mysql` package.

### Database

We first need to create a MariaDB database. For the local installation, we'll create just one.

**Note**: The production server uses two databases: one for `beta.tedxinsa.com` and one for `tedxinsa.com`.

We will use the following values for the parameters:
- MariaDB user: `tedxinsa`
- MariaDB password: `password01` **CHANGE THE PASSWORD!!!**
- MariaDB database: `tedxinsadb`
- MariaDB port: `3306` (this is the default port)
- MariaDB host: `localhost` (requires the DB and PHP engine to be one the same machine)

### General configuration

Follow the [general MariaDB configuration][notes-mariadb-config] (enable full Unicode support).

### Create the database

Open a command line session with the MariaDB root user (this not the Linux root user).
```
mysql --user=root -p
```

The execute the following commands. Adapt the values as needed.

```mysql
CREATE USER 'tedxinsa'@'localhost' IDENTIFIED BY 'password01';
CREATE DATABASE IF NOT EXISTS tedxinsadb;
GRANT ALL PRIVILEGES ON tedxinsadb.* TO 'tedxinsa'@'localhost';
FLUSH PRIVILEGES;
```

Example:

```mysql
MariaDB [(none)]> CREATE USER 'tedxinsa'@'localhost' IDENTIFIED BY 'password01';
Query OK, 0 rows affected (0.10 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS tedxinsadb;
Query OK, 1 row affected (0.04 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS tedxinsadb;
Query OK, 1 row affected (0.04 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON tedxinsadb.* TO 'tedxinsa'@'localhost';
Query OK, 0 rows affected (0.04 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.04 sec)

```

### PHP configuration

Check that the following line is enabled in **/etc/php/php.ini**:

```text
extension=mysqli.so
```

### Environment configuration

Copy the template **.env.example** to **.env** and then edit these values:

```text
# Possible values: development production
WP_ENV=development
# Set the external URI of the root of the website (make sure to add an entry in your `/etc/hosts` file)
WP_HOME=https://tedxinsa.localhost
```

### Dependencies

Install the dependencies by running the following command in the project directory.

```shell
# Run as a normal user
composer install
```

### Optional: nginx

You can optionally configure nginx to handle SSL, caching, virtual hosts, etc.
You don't need it for development, but it may help you to reproduce a production environment.
See [DEPLOYMENT](./DEPLOYMENT.md).
[Use a self-signed certificate][notes-ssl-self-signed].

## Usage

Simply make sure that `nginx`, `php-fpm` and `mariadb` are running, and visit the localhost domain for
the project.

```shell
# Run as root
systemctl start nginx
systemctl start php-fpm
systemctl start mariadb
```

## Wordpress Installation

During the first connection, you will have to configure Wordpress. This section describes the configuration
used by the production website.
Alternatively, use a restore a backup. See below.

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

## Backup

You can create a backup of the database and files by running `tools/backup.sh` **from the
project root**. It will create an archive in the `backups` directory.
To restore the backup, run `tools/restore.sh path/to/backup.tgz` (example: 
`tools/restore.sh 2017-11-06.AZsdgU6t5Cnwr5L5z4dfoarHZ4VpwU5y.tgz`).

## Development

You should only modify the content of the `config` and `web` directories.
You should be mainly interested in the content of the `web/app/themes/tedx-insa` directory where the
them is defined. It extends the [twg/TEDxTheme theme][github-tedx-theme], so any missing file
fallbacks to their theme.

## Deployment

See [DEPLOYMENT](./DEPLOYMENT.md) for the production configuration and deployment.

## License

[MIT License](./LICENSE.md)


[bedrock-home]: https://roots.io/bedrock/
[bedrock-installation]: https://roots.io/bedrock/docs/installing-bedrock/
[github-tedx-theme]: https://github.com/twg/TEDxTheme
[notes-composer]: https://github.com/demurgos/notes/blob/master/tools/languages/php/composer/installation.md
[notes-mariadb]: https://github.com/demurgos/notes/blob/master/tools/databases/mariadb/index.md
[notes-mariadb-config]: https://github.com/demurgos/notes/blob/master/tools/databases/mariadb/configuration.md
[notes-nginx]: https://github.com/demurgos/notes/blob/master/tools/server/nginx/index.md
[notes-php]: https://github.com/demurgos/notes/blob/master/tools/languages/php/index.md
[notes-ssl-self-signed]: https://github.com/demurgos/notes/blob/master/tools/security/ssl/self-signed-certificate/index.md
