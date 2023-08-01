#!/bin/sh

PROJECT_NAME=$1

TEMPLATE_PATH=`dirname $(realpath ${BASH_SOURCE[0]})`
TEMPLATE_NAME=`basename ${TEMPLATE_PATH}`

function createProject() {
    mkdir -p $PROJECT_NAME; cd $PROJECT_NAME
    cp ${TEMPLATE_PATH}/.gitignore .
    cp ${TEMPLATE_PATH}/settings.gradle .
    cp ${TEMPLATE_PATH}/build.gradle .
    cp -r ${TEMPLATE_PATH}/gradle* .
    mkdir buildSrc
    cp  ${TEMPLATE_PATH}/buildSrc/build.gradle ./buildSrc/
    sed -i '' -e "s/${TEMPLATE_NAME}/${PROJECT_NAME}/" ./settings.gradle
}

function createApp() {
    mkdir -p apps; cd apps
    grails create-app ${PROJECT_NAME}-app
    cd ${PROJECT_NAME}-app
    rm -rf .gitignore buildSrc/ settings.gradle  gradle*
    cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/build.gradle .
    cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/gradle.properties .
    cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/conf/application.yml ./grails-app/conf
    sed -i '' -e "s/${TEMPLATE_NAME}/${PROJECT_NAME}/" ./grails-app/conf/application.yml
    cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/conf/logback.xml ./grails-app/conf
    cp ${TEMPLATE_PATH}/apps/${TEMPLATE_NAME}-app/grails-app/views/index.gsp ./grails-app/views
    cd ../..
}

function createPlugin() {
    mkdir -p plugins; cd plugins
    grails create-plugin ${PROJECT_NAME}-plugin
    cd ${PROJECT_NAME}-plugin
    rm -rf .gitignore buildSrc/ settings.gradle  gradle*
    cp ${TEMPLATE_PATH}/plugins/${TEMPLATE_NAME}-plugin/build.gradle .
    cp ${TEMPLATE_PATH}/plugins/${TEMPLATE_NAME}-plugin/gradle.properties .
}

createProject
createApp
createPlugin







