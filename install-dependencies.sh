#!/usr/bin/env bash

set -e

if ! command -v mvn &>/dev/null; then
	cat <<EOF
Please install Maven!

Linux:  sudo apt install -y maven
Mac:  brew install maven
EOF
	exit
fi

CLIENT_VERSION="6.10.2-pg-SNAPSHOT"
JDBC_VERSION="2.2.7-pg-SNAPSHOT"
GRPC_BASE_PATH="artifacts/com/google/api/grpc"
CLOUD_BASE_PATH="artifacts/com/google/cloud"

PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE="proto-google-cloud-spanner-admin-database-v1"
PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE="proto-google-cloud-spanner-admin-instance-v1"
PROTO_GOOGLE_CLOUD_SPANNER="proto-google-cloud-spanner-v1"
GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE="grpc-google-cloud-spanner-admin-database-v1"
GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE="grpc-google-cloud-spanner-admin-instance-v1"
GRPC_GOOGLE_CLOUD_SPANNER="grpc-google-cloud-spanner-v1"
GOOGLE_CLOUD_SPANNER="google-cloud-spanner"
GOOGLE_CLOUD_SPANNER_JDBC="google-cloud-spanner-jdbc"

declare -a dependencies=(
  "${GRPC_BASE_PATH}/${PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE}/${CLIENT_VERSION}/${PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE}-${CLIENT_VERSION}"
  "${GRPC_BASE_PATH}/${PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE}/${CLIENT_VERSION}/${PROTO_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE}-${CLIENT_VERSION}"
  "${GRPC_BASE_PATH}/${PROTO_GOOGLE_CLOUD_SPANNER}/${CLIENT_VERSION}/${PROTO_GOOGLE_CLOUD_SPANNER}-${CLIENT_VERSION}" \

  "${GRPC_BASE_PATH}/${GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE}/${CLIENT_VERSION}/${GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_DATABASE}-${CLIENT_VERSION}"
  "${GRPC_BASE_PATH}/${GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE}/${CLIENT_VERSION}/${GRPC_GOOGLE_CLOUD_SPANNER_ADMIN_INSTANCE}-${CLIENT_VERSION}"
  "${GRPC_BASE_PATH}/${GRPC_GOOGLE_CLOUD_SPANNER}/${CLIENT_VERSION}/${GRPC_GOOGLE_CLOUD_SPANNER}-${CLIENT_VERSION}"

  "${CLOUD_BASE_PATH}/${GOOGLE_CLOUD_SPANNER}/${CLIENT_VERSION}/${GOOGLE_CLOUD_SPANNER}-${CLIENT_VERSION}"
  "${CLOUD_BASE_PATH}/${GOOGLE_CLOUD_SPANNER_JDBC}/${JDBC_VERSION}/${GOOGLE_CLOUD_SPANNER_JDBC}-${JDBC_VERSION}"
)

for (( i=0; i<${#dependencies[@]}; i++));
do
  JAR_FILE="${dependencies[i]}.jar"
  POM_FILE="${dependencies[i]}.pom"

  echo "Installing ${dependencies[i]}..."
  mvn install:install-file -Dfile=${JAR_FILE} -DpomFile=${POM_FILE}
done

mvn compile

echo "Done"
