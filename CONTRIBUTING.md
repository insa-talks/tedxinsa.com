# 

## Dependencies

- _nginx_
- _php_ 7
- _MariaDB_
- _composer_

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

## Configure `.env`

Copy the file **.env.example** to **.env**:

```text
# Possible values: development production
WP_ENV=development
# Set the external URI of the root of the website
WP_HOME=http://tedxinsa.localhost
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

## References

- https://roots.io/bedrock/docs/installing-bedrock/
