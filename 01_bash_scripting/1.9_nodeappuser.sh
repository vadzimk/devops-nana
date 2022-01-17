#!/bin/bash
#check arguments
if [ $# -eq 0 ]
then
        logdir=logs
else
        logdir="$1" # name of log directory
fi

#install node
if ! [ "$(node --version)" ]
then
        echo "installing node"
        apt -y install nodejs
        version=$(node --version)
        echo "installed node version $version"
fi
#install net-tools
if ! [ "$(netstat)" ]
then
        echo "installing net-tools"
        apt -y install net-tools
fi

#install npm
if ! [ "$(npm --verison)" ]
then
        echo "installing npm"
        apt -y install npm
        version=$(npm --version)
        echo "installed npm version $version"
fi
user=appuser

#create service user
if  [ -z "$(cat /etc/passwd | grep $user)" ]
then
        echo "creating service account $user"
       # useradd --system --no-create-home node 
       useradd -m $user # will work in home dir
fi


#create log dir
if ! [ -d "$logdir" ]
then
        echo "creating $logdir"
        runuser -l $user -c "mkdir $logdir" # create in home of $user
fi

#create app dir
if ! [ -d "app" ]
then
        echo "creating app"
        runuser -l $user -c "mkdir app" # create in home of $user
fi

#download source code
if ! [ -f "./app/bootcamp-node-envvars-project-1.0.0.tgz" ]
then
        echo "downloading source"
        runuser -l $user -c "wget -P ./app https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
fi

#unpack
echo "unzipping source"
unzipped=$(runuser -l $user -c "tar -xvf ./app/bootcamp-node-envvars-project-1.0.0.tgz -C ./app")
echo -e "unzipped files:\n$unzipped"

#set env
echo "setting environment variables"
runuser -l $user -c "
export APP_ENV=dev &&
export DB_USER=myuser &&
export DB_PWD=mysecret &&
export LOG_DIR=/home/${user}/${logdir} &&
cd app/package && npm install &&
node server.js &"
printenv APP_ENV
printenv DB_PWD
printenv LOG_DIR


echo "checking that server is running"
application=$(netstat -patun | grep "3000")


        pid=$(echo "$application" | awk '{print $7}')
        echo "port 3000 busy by pid $pid"

        application=$(netstat -patun | grep node)
        echo -e "application running\n$application"

