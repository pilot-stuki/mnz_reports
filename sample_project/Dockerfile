ARG DEBEZIUM_DOCKER_REGISTRY_PRIMARY_NAME="debezium"
FROM $DEBEZIUM_DOCKER_REGISTRY_PRIMARY_NAME/kafka:2.2 as custom-connect-base

LABEL maintainer="Debezium Community"

USER root
RUN microdnf -y install libaio && microdnf clean all

USER kafka

EXPOSE 8083 8778
VOLUME ["/kafka/data","/kafka/logs","/kafka/config"]

COPY docker-entrypoint.sh /
COPY --chown=kafka:kafka log4j.properties $KAFKA_HOME/config/log4j.properties
COPY docker-maven-download.sh /usr/local/bin/docker-maven-download

#
# Set up the plugins directory ...
#
ENV KAFKA_CONNECT_PLUGINS_DIR=$KAFKA_HOME/connect \
    EXTERNAL_LIBS_DIR=$KAFKA_HOME/external_libs \
    CONNECT_PLUGIN_PATH=$KAFKA_CONNECT_PLUGINS_DIR \
    MAVEN_DEP_DESTINATION=$KAFKA_HOME/libs \
    CONFLUENT_VERSION=7.3.3 \
    AVRO_VERSION=1.11.1 \
    APICURIO_VERSION=2.4.1.Final \
    GUAVA_VERSION=32.0.1-jre \
    JOLOKIA_VERSION=1.7.2

RUN mkdir "$KAFKA_CONNECT_PLUGINS_DIR" "$EXTERNAL_LIBS_DIR"

ENV DEBEZIUM_VERSION="2.2.1.Final" \
    MAVEN_REPO_CENTRAL="" \
    MAVEN_REPOS_ADDITIONAL="" \
    MAVEN_DEP_DESTINATION=$KAFKA_CONNECT_PLUGINS_DIR \
    AVROCONNECTOR_MD5=f5ecf29b85e25775f5cbf10830910223 \
    AVRODATA_MD5=039db1f90bd7e2fb9ce7de6884d7369c \
    AVROSERIALIZER_MD5=e53c0c6b17cb02879d659177efa486a7 \
    SCHEMASERIALIZER_MD5=7a39b5c4bad4a9c4451a05d81cc3f210 \
    SCHEMAREGITSRY_MD5=37d24beb1144e16a6c001ba9dd863a74 \
    COMMONCONFIG_MD5=ed45877603bc469534810d95664c2869 \
    COMMONUTILS_MD5=60316af258750f9678fb2a5d7e29cd3a \
    AVRO_MD5=9fad4fb0e34810ae5f3d7cb5223a7e1c \
    APICURIO_MD5=ead18a95038adca54e91b7f253717eb7 \
    GUAVA_MD5=6951895e804b36322214c95917e598d4 \
    JOLOKIA_MD5=d489d62d1143e6a2e85a869a4b824a67

#
# The `docker-entrypoint.sh` script will automatically discover the child directories
# within the $KAFKA_CONNECT_PLUGINS_DIR directory (e.g., `/kafka/connect`), and place
# all of the files in those child directories onto the Java classpath.
#
# The general recommendation is to create a separate child directory for each connector
# (e.g., "debezium-connector-mysql"), and to place that connector's JAR files
# and other resource files in that child directory.
#
# However, use a single directory for connectors when those connectors share dependencies.
# This will prevent the classes in the shared dependencies from appearing in multiple JARs
# on the classpath, which results in arcane NoSuchMethodError exceptions.
#

RUN docker-maven-download confluent kafka-connect-avro-converter "$CONFLUENT_VERSION" "$AVROCONNECTOR_MD5"  && \
    docker-maven-download confluent kafka-connect-avro-data "$CONFLUENT_VERSION" "$AVRODATA_MD5" && \
    docker-maven-download confluent kafka-avro-serializer "$CONFLUENT_VERSION" "$AVROSERIALIZER_MD5" && \
    docker-maven-download confluent kafka-schema-serializer "$CONFLUENT_VERSION" "$SCHEMASERIALIZER_MD5" && \
    docker-maven-download confluent kafka-schema-registry-client "$CONFLUENT_VERSION" "$SCHEMAREGITSRY_MD5" && \
    docker-maven-download confluent common-config "$CONFLUENT_VERSION" "$COMMONCONFIG_MD5" && \
    docker-maven-download confluent common-utils "$CONFLUENT_VERSION" "$COMMONUTILS_MD5" && \
    docker-maven-download central org/apache/avro avro "$AVRO_VERSION" "$AVRO_MD5" && \
    docker-maven-download apicurio "$APICURIO_VERSION" "$APICURIO_MD5" && \
    docker-maven-download central com/google/guava guava "$GUAVA_VERSION" "$GUAVA_MD5" \
    docker-maven-download central org/jolokia jolokia-jvm "$JOLOKIA_VERSION" "$JOLOKIA_MD5"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]

FROM custom-connect-base

ENV MONGODB_MD5=f773a5fdc84c9b9157dcea4559a84db7 \
    MYSQL_MD5=c83cd14a7db7b7244d711a741735b1de \
    POSTGRES_MD5=dee4403afada17d281af7b1284608d0b \
    SQLSERVER_MD5=a0d307fde0d356973d924f21acce9927 \
    ORACLE_MD5=c698e3a94accd97181039fe47f4bc8b7 \
    DB2_MD5=94980de1c3b0c881e0695247be0b213e \
    SPANNER_MD5=51eea81d20f29e7fa3676b0f2ae990cd \
    VITESS_MD5=7dfafc0b6279c2f0cf29dc4d1e1da263 \
    JDBC_MD5=a51e005d3d713182c8706f71006a5944 \
    KCRESTEXT_MD5=38dc3dcd1d4f3cdfe03f1ffc229c64d3 \
    SCRIPTING_MD5=d0b9056c657a571cc95102d712efc626

RUN docker-maven-download debezium mongodb "$DEBEZIUM_VERSION" "$MONGODB_MD5" && \
    docker-maven-download debezium mysql "$DEBEZIUM_VERSION" "$MYSQL_MD5" && \
    docker-maven-download debezium postgres "$DEBEZIUM_VERSION" "$POSTGRES_MD5" && \
    docker-maven-download debezium sqlserver "$DEBEZIUM_VERSION" "$SQLSERVER_MD5" && \
    docker-maven-download debezium oracle "$DEBEZIUM_VERSION" "$ORACLE_MD5" && \
    docker-maven-download debezium-additional db2 db2 "$DEBEZIUM_VERSION" "$DB2_MD5" && \
    docker-maven-download debezium-additional jdbc jdbc "$DEBEZIUM_VERSION" "$JDBC_MD5" && \
    docker-maven-download debezium-additional spanner spanner "$DEBEZIUM_VERSION" "$SPANNER_MD5" && \
    docker-maven-download debezium-additional vitess vitess "$DEBEZIUM_VERSION" "$VITESS_MD5" && \
    docker-maven-download debezium-optional connect-rest-extension "$DEBEZIUM_VERSION" "$KCRESTEXT_MD5" && \
    docker-maven-download debezium-optional scripting "$DEBEZIUM_VERSION" "$SCRIPTING_MD5"