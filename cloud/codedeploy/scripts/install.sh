#!/usr/bin/env bash
ECR_TAG=608525754125.dkr.ecr.us-east-1.amazonaws.com/paystats:latest
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 608525754125.dkr.ecr.us-east-1.amazonaws.com
docker pull $ECR_TAG
docker tag $ECR_TAG app:latest