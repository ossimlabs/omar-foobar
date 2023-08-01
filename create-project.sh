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

    # Add default app
    mkdir -p apps; cd apps
    ${TEMPLATE_PATH}/create-app.sh $PROJECT_NAME
    cd ..

    # Add default plugin
    mkdir -p plugins; cd plugins
    ${TEMPLATE_PATH}/create-plugin.sh $PROJECT_NAME
    cd ..

    # Add skaffold
    cp ${TEMPLATE_PATH}/skaffold.yaml .
    sed -i '' -e "s/${TEMPLATE_NAME}/${PROJECT_NAME}/" ./skaffold.yaml
}

createProject







