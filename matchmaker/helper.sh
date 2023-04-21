#!/bin/bash

increment_semantic_version() {
  IMAGE_VERSION=$1

  if ! is_semantic_version "$IMAGE_VERSION"; then
    echo "invalid semantic version"
    return 1
  fi

  # Split the version number into its components
  major=$(echo $1 | cut -d '.' -f 1)
  minor=$(echo $1 | cut -d '.' -f 2)
  patch=$(echo $1 | cut -d '.' -f 3)

  # Increment the patch version
  patch=$((patch + 1))

  # Combine the components into a new version number
  new_version="$major.$minor.$patch"

  # Output the new version number
  echo "$new_version"
}

is_semantic_version() {
    # Check if the argument matches the semantic versioning pattern
    if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?(\+[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$ ]]; then
        return 0
    else
        return 1
    fi
}

get_latest_version() {
  IMAGE_NAME_REGEX=$1
  IMAGE_VERSION=$(docker images | grep "$IMAGE_NAME_REGEX" | sort -k2 -r | head -n1 | awk '{print $2}')

  if ! is_semantic_version "$IMAGE_VERSION"; then
    echo "no valid semantic version found"
    return 1
  else
    return "$IMAGE_VERSION"
  fi
}