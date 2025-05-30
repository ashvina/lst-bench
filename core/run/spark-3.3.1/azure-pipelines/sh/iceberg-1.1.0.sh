#!/bin/bash -e
source env.sh
if [ -z "${SPARK_HOME}" ]; then
    echo "ERROR: SPARK_HOME is not defined."
    exit 1
fi

if [ -f "$HOME/iceberg-spark-runtime-custom.jar" ]; then
    echo "Custom Iceberg Spark runtime jar is provided."
    ln -sf $HOME/iceberg-spark-runtime-custom.jar $SPARK_HOME/jars/iceberg-spark-runtime.jar
else
    echo "Downloading Iceberg runtime jar..."
    wget -nv -N https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.8.0/iceberg-spark-runtime-3.5_2.12-1.8.0.jar
    ln -sf $(pwd)/iceberg-spark-runtime-3.5_2.12-1.8.0.jar $SPARK_HOME/jars/iceberg-spark-runtime.jar
fi
