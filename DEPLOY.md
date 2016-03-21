# Initial setup (App Engine)

Add PHP String keys to memcache in app engine to use with wp-config.php

* DB Connection Information
*   DB_HOST: :/cloudsql/{GOOGLE_PROJECT}:{SQL_INSTANCE}
* WordPress Keys {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}:
*   AUTH_KEY
*   SECURE_AUTH_KEY
*   LOGGED_IN_KEY
*   NONCE_KEY
*   AUTH_SALT
*   SECURE_AUTH_SALT
*   LOGGED_IN_SALT
*   NONCE_SALT

# Initial setup (Storage Bucket)

Create a bucket for use as upload directory
* naming is important - must be unique across Google Cloud Storage
* select an appropriate storage class
* select an appropriate location based on where the app will run


# Initial setup (Cloud SQL)

* Create the 'wordpress_db' database
* Allow the {GOOGLE_PROJECT} application access
* If available, set 'Preferred location' to follow app {GOOGLE_PROJECT}

# WordPress config

* Make sure the appengine plugin is enabled and set to connect to the correct bucket

# Deploy from google cloud shell

* cd /path/to/src/
* gcloud config set project GOOGLE_PROJECT
* modify app.yaml as needed
* sh deploy.sh GOOGLE_PROJECT
  
# Upgrade wordpress

* cd /path/to/src/wordpress-src
* git checkout BRANCH
* cd /path/to/src/
* sh deploy.sh GOOGLE_PROJECT

# Useful git submodule settings/commands

git config status.submodulesummary 1

