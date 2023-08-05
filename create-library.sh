#!/bin/sh

PROJECT_NAME=$1

TEMPLATE_PATH=`dirname $(realpath ${BASH_SOURCE[0]})`
TEMPLATE_NAME=`basename ${TEMPLATE_PATH}`

function createLibrary() {
  mkdir ${PROJECT_NAME}-lib
  cd ${PROJECT_NAME}-lib
  mkdir -p src/main/groovy
  cp ${TEMPLATE_PATH}/libs/${TEMPLATE_NAME}-lib/build.gradle .
  cp ${TEMPLATE_PATH}/libs/${TEMPLATE_NAME}-lib/gradle.properties .
}

createLibrary
