#! /bin/bash
PROJECT_ROOT=$(dirname "$0")

source "$PROJECT_ROOT/project_env.sh"

docker build -f "$PROJECT_ROOT/Docker/Dockerfile-Ansible" -t $ANSIBLE_IMAGE_NAME:$ANSIBLE_IMAGE_TAG "$PROJECT_ROOT"
