#!/bin/bash
function java_found {
	version=$(java -version 2>&1) # somehow output was in stderr
	if [ $? -eq 0 ]
	then
		echo java found $version
		return 0
	else
		echo java not found
		return 1
	fi
}

function install_java {
		apt update
		version=$1
		if [ -n "$version" ]
		then
			echo installing java version $version
			apt -y install "openjdk-$version-jdk"
		else
			apt -y install "openjdk-8-jdk"
		fi
		
		return $?
}

#exec 2> /dev/null # surpress error output
java_found

if [ $? -eq 1 ]
then
	install_java $1
	if [ $? -eq 0 ]
	then
		echo installed $(java -version)
	fi
fi




#exec 2>&2

