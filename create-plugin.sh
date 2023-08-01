#!/bin/sh

PROJECT_NAME=$1

TEMPLATE_PATH=`dirname $(realpath ${BASH_SOURCE[0]})`
TEMPLATE_NAME=`basename ${TEMPLATE_PATH}`

function createPlugin() {
  grails create-plugin ${PROJECT_NAME}-plugin
  cd ${PROJECT_NAME}-plugin
  rm -rf .gitignore buildSrc/ settings.gradle  gradle*
  cp ${TEMPLATE_PATH}/plugins/${TEMPLATE_NAME}-plugin/build.gradle .
  cp ${TEMPLATE_PATH}/plugins/${TEMPLATE_NAME}-plugin/gradle.properties .
}

createPlugin
