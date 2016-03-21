For this documentation (DEPLOY.md), the commands presented are being run via the Google Cloud Shell

## Initial setup

* Add a project to Google compute
* clone this project recursively

```bash
cd /path/to/project/source
git clone --recursive https://github.com/jdkindy/appengine-php-wordpress-starter-project.git [LOCAL_DIR]
```

### App Engine

Add environment variables to settings.yaml (based on settings.yaml.example) to use with wp-config.php

* DB Connection Information
  * DB_HOST: :/cloudsql/{GOOGLE_PROJECT}:{SQL_INSTANCE}
* WordPress Keys - obtain from [WordPress.org secret-key service](https://api.wordpress.org/secret-key/1.1/salt/ "WordPress.org secret-key service") or pick your own
  * AUTH_KEY
  * SECURE_AUTH_KEY
  * LOGGED_IN_KEY
  * NONCE_KEY
  * AUTH_SALT
  * SECURE_AUTH_SALT
  * LOGGED_IN_SALT
  * NONCE_SALT

### Storage Bucket

Create a bucket for use as upload directory
* naming is important - must be unique across Google Cloud Storage
* select an appropriate storage class
* select an appropriate location based on where the app will run

### Cloud SQL

* Create the 'wordpress_db' database
* Allow the {GOOGLE_PROJECT} application access
* If available, set 'Preferred location' to follow app {GOOGLE_PROJECT}

## WordPress config

* Make sure the appengine plugin is enabled and set to connect to the correct bucket

## Deploy from Google cloud shell

```bash
cd /path/to/src/
sh deploy.sh GOOGLE_PROJECT
```
  
## Upgrade/Change wordpress version

```bash
cd /path/to/src/wordpress-src
git fetch
git checkout BRANCH|TAG
cd /path/to/src/
sh deploy.sh GOOGLE_PROJECT
```

## Update all software

```bash
cd /path/to/src/
git fetch --recurse-submodules
sh deploy.sh GOOGLE_PROJECT
```

## Add a plugin

Find a repository for the plugin and determine the branch/tag you want to use. Replace LOCAL_DIR below with the name of the directory you will be using for the plugin.

```bash
cd /path/to/src/
git submodule add git@githost:/path/to/module.git LOCAL_DIR
# Add a line to skip_files in app.yaml
# - ^LOCAL_DIR/(.*)$
cd LOCAL_DIR
sh deploy.sh GOOGLE_PROJECT
```

## Useful git submodule settings/commands

* git config status.submodulesummary 1
* Update the repositories for all submodules
  * `git fetch --recurse-submodules`
