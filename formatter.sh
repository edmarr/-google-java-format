#!/bin/bash
set -e

RELEASE=1.9
JAR_NAME="google-java-format-${RELEASE}-all-deps.jar"
RELEASES_URL=https://github.com/google/google-java-format/releases/download/google-java-format-
JAR_URL="${RELEASES_URL}${RELEASE}/${JAR_NAME}"

CACHE_DIR="$HOME/.cache/google-java-format-git-pre-commit-hook"
JAR_FILE="$CACHE_DIR/$JAR_NAME"
JAR_DOWNLOAD_FILE="${JAR_FILE}.tmp"

if [[ ! -f "$JAR_FILE" ]]
then
    mkdir -p "$CACHE_DIR"
    curl -L "$JAR_URL" -o "$JAR_DOWNLOAD_FILE"
    mv "$JAR_DOWNLOAD_FILE" "$JAR_FILE"
fi

changed_java_files=$( git diff @~..@ --name-only | grep -Ei "\.java$" || true)
if [[ -n "$changed_java_files" ]]
then
    if ! java -jar "$JAR_FILE" --replace --set-exit-if-changed $changed_java_files
    then
        echo "Reformatting java files!"
    fi
else
    echo "No changes!"
fi
