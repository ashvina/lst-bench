#!/bin/bash

# Define URLs for Hadoop and Spark
HADOOP_URL="https://archive.apache.org/dist/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz"
SPARK_URL="https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop3.tgz"

# Define file names
HADOOP_FILE="hadoop-3.3.1.tar.gz"
SPARK_FILE="spark-$SPARK_VERSION-bin-hadoop3.tgz"

# Check and download Hadoop if not present
if [ ! -f "$HADOOP_FILE" ]; then
  echo "Downloading Hadoop..."
  wget -nv -N "$HADOOP_URL"
else
  echo "Hadoop already downloaded."
fi

# Check and download Spark if not present
if [ ! -f "$SPARK_FILE" ]; then
  echo "Downloading Spark..."
  wget -nv -N "$SPARK_URL"
else
  echo "Spark already downloaded."
fi
