#! /bin/bash

PROJECT_ROOT=$(dirname "$0")
pushd "$PROJECT_ROOT" > /dev/null
PROJECT_ROOT=$(pwd)
popd > /dev/null

# Variables
ANSIBLE_IMAGE_NAME=star_app_platform_ansible
ANSIBLE_IMAGE_TAG=latest
