#!/usr/bin/env bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 608525754125.dkr.ecr.us-east-1.amazonaws.com
docker pull 608525754125.dkr.ecr.us-east-1.amazonaws.com/paystats:latest
docker tag 608525754125.dkr.ecr.us-east-1.amazonaws.com/paystats:latest app:latest