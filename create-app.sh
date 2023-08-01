#!/bin/sh

PROJECT_NAME=$1

TEMPLATE_PATH=`dirname $(realpath ${BASH_SOURCE[0]})`
TEMPLATE_NAME=`basename ${TEMPLATE_PATH}`

function createApp() {
  grails create-app ${PROJECT_NAME}-app
  cd ${PROJECT_NAME}-app
  rm -rf .gitignore buildSrc/ settings.gradle  gradle*
  cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/build.gradle .
  cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/gradle.properties .
  cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/conf/application.yml ./grails-app/conf
  sed -i '' -e "s/${TEMPLATE_NAME}/${PROJECT_NAME}/" ./grails-app/conf/application.yml
  cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/conf/logback.xml ./grails-app/conf
  cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/views/index.gsp ./grails-app/views
}

createApp