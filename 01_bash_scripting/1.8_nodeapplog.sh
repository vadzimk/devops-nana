#!/bin/bash
#check arguments
if [ $# -eq 0 ]
then
        echo "Usage: $0 <log_dir_name>"
        exit 1
fi
logdir="$1" # name of log directory
echo "logdir=$logdir"
#create log dir
if ! [ -d "$logdir" ]
then
        mkdir "$logdir"
fi
#install node
if ! [ "$(node --version)" ]
then
        apt -y install nodejs
        version=$(node --version)
        echo "installed node version $version"
fi
#install net-tools
if ! [ "$(netstat)" ]
then
        apt -y install net-tools
fi

#install npm
if ! [ "$(npm --verison)" ]
then
        apt -y install npm
        version=$(npm --version)
        echo "installed npm version $version"
fi
#create app dir
if ! [ -d "app" ]
then
        mkdir app
fi
#download source code
if ! [ -f "./app/bootcamp-node-envvars-project-1.0.0.tgz" ]
then
        wget -P ./app https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
fi
#unpack
unzipped=$(tar -xvf ./app/bootcamp-node-envvars-project-1.0.0.tgz -C ./app)
echo -e "unzipped files:\n$unzipped"
#set env
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
export LOG_DIR="$(pwd)/${logdir}"
echo "logdir=$logdir"
echo "LOG_DIR="
printenv LOG_DIR

cd ./app/package || exit 1

npm install


node server.js &

application=$(netstat -patun | grep "3000")


        pid=$(echo "$application" | awk '{print $7}')
        echo "port 3000 busy by pid $pid"

        application=$(netstat -patun | grep node)
        echo -e "application running\n$application"

