#!/bin/bash
set -o pipefail
IFS=$'\n\t'

DOCKER_SOCKET=/var/run/docker.sock

echo "DEBUG:"
echo "DEBUG: Output environment value"
echo "DEBUG: ------------------------"
env
echo "DEBUG:"

if [ ! -e "${DOCKER_SOCKET}" ]; then
  echo "Docker socket missing at ${DOCKER_SOCKET}"
  exit 1
fi

if [ -n "${OUTPUT_IMAGE}" ]; then
  TAG="${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}"
fi

if [[ "${SOURCE_REPOSITORY}" != "git://"* ]] && [[ "${SOURCE_REPOSITORY}" != "git@"* ]]; then
  URL="${SOURCE_REPOSITORY}"
  if [[ "${URL}" != "http://"* ]] && [[ "${URL}" != "https://"* ]]; then
    URL="https://${URL}"
  fi
  curl --head --silent --fail --location --max-time 16 $URL > /dev/null
  if [ $? != 0 ]; then
    echo "Could not access source url: ${SOURCE_REPOSITORY}"
    exit 1
  fi
fi

if [ -n "${SOURCE_REF}" ]; then
  BUILD_DIR=$(mktemp --directory --suffix=docker-build)

  echo "DEBUG:"
  echo "DEBUG: git clone with TRACE logs"
  echo "DEBUG: ------------------------"
  GIT_CURL_VERBOSE=1 git clone --recursive "${SOURCE_REPOSITORY}" "${BUILD_DIR}"
  echo "DEBUG:"
  
  if [ $? != 0 ]; then
    echo "Error trying to fetch git source: ${SOURCE_REPOSITORY}"
    exit 1
  fi
  pushd "${BUILD_DIR}"
  git checkout "${SOURCE_REF}"
  if [ $? != 0 ]; then
    echo "Error trying to checkout branch: ${SOURCE_REF}"
    exit 1
  fi

  echo "DEBUG:"
  echo "DEBUG: Check source code"
  echo "DEBUG: ------------------------"
  echo "DEBUG:"
  echo "DEBUG: git commit log:"
  echo "DEBUG:"
  git log -n 1 --format=%H
  echo "DEBUG:"
  echo "DEBUG: files in source code top directory"
  echo "DEBUG:"
  ls -l
  echo "DEBUG:"

  popd
  docker build --rm -t "${TAG}" "${BUILD_DIR}"
else
  docker build --rm -t "${TAG}" "${SOURCE_REPOSITORY}"
fi

if [[ -d /var/run/secrets/openshift.io/push ]] && [[ ! -e /root/.dockercfg ]]; then
  cp /var/run/secrets/openshift.io/push/.dockercfg /root/.dockercfg
fi

echo "DEBUG:"
echo "DEBUG: Output docker info"
echo "DEBUG: ------------------------"
docker info
echo "DEBUG:"

if [ -n "${OUTPUT_IMAGE}" ] || [ -s "/root/.dockercfg" ]; then
  docker push "${TAG}"
fi
