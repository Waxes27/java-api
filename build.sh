#!/bin/bash

cd $HOME/java-api/console_app
rm build -rf && flutter build web
cp build/web/* -r /var/www/html/