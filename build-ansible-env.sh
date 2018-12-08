#! /bin/bash
PROJECT_ROOT=$(dirname "$0")

source "$PROJECT_ROOT/project_env.sh"

# Gitlab ci
if ! [ -z "$GITLAB_CI" ]; then
    IMAGE_REF_NAME=$CI_REGISTRY_IMAGE/$ANSIBLE_IMAGE_NAME:$CI_COMMIT_REF_NAME
else
    IMAGE_REF_NAME=$ANSIBLE_IMAGE_NAME:$ANSIBLE_IMAGE_TAG
fi

docker build -f "$PROJECT_ROOT/Docker/Dockerfile-Ansible" -t $IMAGE_REF_NAME "$PROJECT_ROOT"

if ! [ -z "$GITLAB_CI" ] ; then
    docker login -u gitlab-ci-token -p $CI_JOB_TOKEN $CI_REGISTRY
    docker push $IMAGE_REF_NAME
fi
