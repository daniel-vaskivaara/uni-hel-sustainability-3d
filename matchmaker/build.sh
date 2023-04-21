#!/bin/bash

IMAGE_NAME=matchmaker
IMAGE_VERSION=$1

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
. .env
. "$SCRIPT_DIR/helper.sh"

if ! is_semantic_version "$IMAGE_VERSION"; then
  IMAGE_VERSION=$(get_latest_version "$IMAGE_NAME_REGEX")
fi
NEW_VERSION=$(increment_semantic_version "$IMAGE_VERSION")
 docker build --tag "$IMAGE_NAME:$IMAGE_VERSION" --file "$SCRIPT_DIR"/Dockerfile .
 docker tag "$IMAGE_NAME:$1" 698794391023.dkr.ecr.eu-north-1.amazonaws.com/pixel_stream/"$IMAGE_NAME:$IMAGE_VERSION"