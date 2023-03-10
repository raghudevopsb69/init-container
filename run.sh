#!/bin/bash

if [ "$skip_schema" == "true" ]; then
  echo "Skipping Schema"
  exit
fi

git clone https://github.com/raghudevopsb69/$component
cd $component/schema

if [ "$dbtype" == "mysql" ]; then
  echo "GRANT ALL ON cities.* TO 'shipping'@'%' IDENTIFIED BY 'secret';" | mysql -h $dbhost -u$dbuser -p$dbpass
  mysql -h $dbhost -u$dbuser -p$dbpass <$component.sql
fi

if [ "$dbtype" == "mongo" ]; then
  curl -L -O https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
  mongo --ssl --host $dbhost:27017 --sslCAFile rds-combined-ca-bundle.pem --username $dbuser --password $dbpass < $component.js
fi

