#!/bin/bash -e
source env.sh
if [ -z "${HOSTS}" ]; then
    echo "ERROR: HOSTS is not defined."
    exit 1
fi

if [ "$#" -lt 2 ]; then
    echo "Error: Please provide at least two input parameters."
    exit 1
fi
deploy_dir=$1
script_file=$2

for node in $HOSTS   ; do ssh -t $node "mkdir -p ~/$deploy_dir" ; done
for node in $HOSTS   ; do scp *.template $node:~/$deploy_dir ; done
for node in $HOSTS   ; do scp ./hadoop-3.3.1.tar.gz $node:~/$deploy_dir ; done
for node in $HOSTS   ; do scp ./spark-$SPARK_VERSION-bin-hadoop3.tgz $node:~/$deploy_dir ; done
for node in $HOSTS   ; do scp ~/spark/conf/spark-defaults.conf $node:~/$deploy_dir/ ; done
for node in $HOSTS   ; do scp ~/spark/conf/spark-env.sh $node:~/$deploy_dir ; done
for node in $HOSTS   ; do scp $script_file $node:~/$deploy_dir ; done

for node in $HOSTS   ; do ssh -t $node "sudo apt-get update" ; done
for node in $HOSTS   ; do ssh -t $node "sudo apt install -y $JDK_INSTALLER_NAME wget" ; done
for node in $HOSTS   ; do ssh -t $node "export JDK_HOME=$JDK_HOME; export SPARK_VERSION=$SPARK_VERSION; cd ~/$deploy_dir && chmod +x ./$script_file && ./$script_file ${@:3}" ; done

