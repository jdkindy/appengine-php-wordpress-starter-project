#!/bin/sh

#  prep_for_deploy.sh
#  WAS:move_files_after_editing.sh
#  
#
#  Modified by Jeremy Kindy on 2016/03/18
#  - prepare for deployment non-destructively
#  - check for app.yaml in local directory
#  - be more descriptive
#  - require project name argument
#
#  Created by John Mulhausen on 10/17/13.
#

if [ ! -r './app.yaml' ]; then
  echo './app.yaml is not readable or does not exist - are you in the right location?'
  exit 1
fi

if [ -z "$1" ]; then
  echo 'please provide a project to deploy to...'
  exit 1
else
  PROJECT_NAME="$1"
fi

echo 'Removing old wordpress...'
rm -rf wordpress/

echo 'Copy wordpress-src to wordpress/...'
cp -fr wordpress-src/ wordpress/

echo 'Copy wp-config to wordpress/...'
cp -fr wp-config.php wordpress/

echo 'Copy batcache to wordpress/...'
cp -fr batcache/advanced-cache.php wordpress/wp-content/
cp -fr batcache/batcache.php wordpress/wp-content/plugins/

echo 'Copy wp-memcache to wordpress/...'
cp -fr wp-memcache/object-cache.php wordpress/wp-content/

echo 'Copy appengine plugin to wordpress/...'
cp -fr appengine-wordpress-plugin/. wordpress/wp-content/plugins/

echo 'Starting deploy...'
gcloud preview app deploy ./app.yaml --project ${PROJECT_NAME}
