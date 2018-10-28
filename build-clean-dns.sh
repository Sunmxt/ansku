#! /bin/bash
PROJECT_ROOT=$(dirname "$0")

source "$PROJECT_ROOT/project_env.sh"

docker build -f "$PROJECT_ROOT/Docker/Dockerfile-CleanDNS" -t $CLEAN_DNS_IMAGE_NAME:$CLEAN_DNS_IMAGE_TAG "$PROJECT_ROOT"
