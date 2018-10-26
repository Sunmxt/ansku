#! /bin/bash

PROJECT_ROOT=$(dirname "$0")
source "$PROJECT_ROOT/project_env.sh"
"$PROJECT_ROOT/build-ansible-env.sh"

docker run -it -v $PROJECT_ROOT:/home/deploy $ANSIBLE_IMAGE_NAME:$ANSIBLE_IMAGE_TAG sh -c "cd /home/deploy; sh"
