#!/bin/bash -e
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 SPARK_MASTER_HOST DATA_STORAGE_ACCOUNT DATA_STORAGE_ACCOUNT_SHARED_KEY"
    exit 1
fi

if [ -z "${USER}" ]; then
    echo "ERROR: USER is not defined."
    exit 1
fi

export SPARK_MASTER_HOST=$1
export SPARK_HOME=$HOME/spark
export HADOOP_HOME=$HOME/hadoop
export JAVA_HOME=$JDK_HOME
export DATA_STORAGE_ACCOUNT=$2
export DATA_STORAGE_ACCOUNT_SHARED_KEY=$3

printenv

# Install Hadoop
rm -rf hadoop-3.3.1
tar -xzf hadoop-3.3.1.tar.gz
ln -sf $(pwd)/hadoop-3.3.1 $HADOOP_HOME

# Install Spark
rm -rf spark-$SPARK_VERSION-bin-hadoop3
tar -xf spark-$SPARK_VERSION-bin-hadoop3.tgz
ln -sf $(pwd)/spark-$SPARK_VERSION-bin-hadoop3 $SPARK_HOME

# Configure Spark
sudo mkdir -p /opt/spark-events
sudo chown $USER:$USER /opt/spark-events/

cp $HOME/spark-$SPARK_VERSION/spark-env.sh $SPARK_HOME/conf/spark-env.sh
cp $HOME/spark-$SPARK_VERSION/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

sudo mkdir -p /mnt/local_resource/
sudo mkdir -p /mnt/local_resource/data/
sudo chown $USER:$USER /mnt/local_resource/data
sudo mkdir -p /mnt/local_resource/tmp/
sudo chown $USER:$USER /mnt/local_resource/tmp

# Copy Azure dependencies to Spark classpath
cp $HADOOP_HOME/share/hadoop/tools/lib/hadoop-azure* $SPARK_HOME/jars/

# Push to environment
echo "export HADOOP_HOME=${HADOOP_HOME}
export SPARK_HOME=${SPARK_HOME}
export JAVA_HOME=${JAVA_HOME}
export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin" >> env.sh
echo "source $(pwd)/env.sh" >> ~/.bashrc
