#!/usr/bin/env bash

RUNNING_CONTAINERS=$(docker ps -q)
if [ "$RUNNING_CONTAINERS" ]; then
  docker stop $RUNNING_CONTAINERS
fi
