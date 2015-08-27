#!/bin/bash

BUILD_DIR=$(mktemp --directory --suffix=docker-build)
GIT_CURL_VERBOSE=1 GIT_TRACE=1 git clone --recursive "${SOURCE_REPOSITORY}" "${BUILD_DIR}"
