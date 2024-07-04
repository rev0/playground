#!/bin/bash

#default values for pyspark and SPARK_HOME
PYSPARK="3.5.1"
SPARKHOME="/content/spark-3.5.1-bin-hadoop3"

while getopts v: option
do
 case "${option}"
 in
 v) PYSPARK=${OPTARG};;
 esac
done

echo "setup Colab for PySpark $PYSPARK"
apt-get update
apt-get purge -y openjdk-11* -qq > /dev/null && sudo apt-get autoremove -y -qq > /dev/null
apt-get install -y openjdk-8-jdk-headless -qq > /dev/null

if [[ "$PYSPARK" == "3.5"* ]]; then
  wget -q "https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz" > /dev/null
  tar -xvf spark-3.5.1-bin-hadoop3.tgz > /dev/null
  SPARKHOME="/content/spark-3.5.1-bin-hadoop3"
elif [[ "$PYSPARK" == "3.0"* ]]; then
  wget -q "https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.3-bin-hadoop3.2.tgz" > /dev/null
  tar -xvf spark-3.0.3-bin-hadoop3.2.tgz > /dev/null
  SPARKHOME="/content/spark-3.0.3-bin-hadoop3.2"
elif [[ "$PYSPARK" == "2"* ]]; then
  wget -q "https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz" > /dev/null
  tar -xvf spark-2.4.7-bin-hadoop2.7.tgz > /dev/null
  SPARKHOME="/content/spark-2.4.7-bin-hadoop2.7"
else
  wget -q "https://downloads.apache.org/spark/spark-3.1.3/spark-3.1.3-bin-hadoop3.2.tgz" > /dev/null
  tar -xvf spark-3.1.3-bin-hadoop3.2.tgz > /dev/null
  SPARKHOME="/content/spark-3.1.3-bin-hadoop3.2"
fi

export SPARK_HOME=$SPARKHOME
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

# Install pyspark
! pip install --upgrade -q pyspark==$PYSPARK findspark
