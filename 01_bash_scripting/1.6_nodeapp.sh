#!/bin/bash

if ! [ $(node --version) ]
then
	apt -y install nodejs
	version=$(node --version)
	echo "installed node version $version"
fi

if ! [ $(npm --verison) ]
then
	apt -y install npm
	version=$(npm --version)
	echo "installed npm version $version"
fi

if ! [ -d "app" ]
then
	mkdir app
fi

if ! [ -f "./app/bootcamp-node-envvars-project-1.0.0.tgz" ]
then
	wget -P ./app https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
fi

unzipped=$(tar -xvf ./app/bootcamp-node-envvars-project-1.0.0.tgz -C ./app)
echo -e "unzipped files:\n$unzipped"

export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

cd ./app/package

npm install
node server.js &

