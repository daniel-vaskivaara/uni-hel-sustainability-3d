#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
. .env
. "$SCRIPT_DIR/helper.sh"


IMAGE_VERSION=$1

if ! is_semantic_version "$IMAGE_VERSION"; then
  IMAGE_VERSION=$(get_latest_version "$IMAGE_NAME_REGEX")
fi
docker run -dit --init --rm --name "$IMAGE_NAME" "$IMAGE_NAME":"$IMAGE_VERSION"