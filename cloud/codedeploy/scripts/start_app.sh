#!/usr/bin/env bash

# if [ "$DEPLOYMENT_GROUP_NAME" == "paystats-dev" ]
# then
#     export APP_ENV=dev
# fi

echo $DEPLOYMENT_GROUP_NAME

export APP_ENV=dev

aws configure set default.region us-east-1

export DATABASE_HOST=$(aws ssm get-parameter --name /paystats/$APP_ENV/database_host | jq '.Parameter.Value')
export DATABASE_USER=$(aws ssm get-parameter --name /paystats/$APP_ENV/database_user | jq '.Parameter.Value')
export DATABASE_PASSWORD=$(aws ssm get-parameter --name /paystats/$APP_ENV/database_password | jq '.Parameter.Value')
export SECRET_KEY_BASE=$(aws ssm get-parameter --name /paystats/$APP_ENV/secret_key_base | jq '.Parameter.Value')
docker run -p 80:3000 -e RAILS_ENV=$APP_ENV -e DATABASE_HOST=$DATABASE_HOST -e DATABASE_USER=$DATABASE_USER -e DATABASE_PASSWORD=$DATABASE_PASSWORD -e SECRET_KEY_BASE=$SECRET_KEY_BASE -d app:latest