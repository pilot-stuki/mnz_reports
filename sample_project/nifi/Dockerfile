# Use the official Apache NiFi image as the base image
FROM apache/nifi:latest

# The version of the nifi-kite-nar package to install
ARG NIFI_KITE_NAR_VERSION=1.15.3
ARG NIFI_HIVE_NAR_VERSION=1.22.0
# The version of the Microsoft SQL Server JDBC driver to install
ARG MSSQL_JDBC_VERSION=12.2.0.jre8

# The base directory where NiFi is installed
ENV NIFI_BASE_DIR=/opt/nifi/nifi-current

# Download the nifi-kite-nar package and install it into the NiFi lib directory
RUN curl -fSL https://repo1.maven.org/maven2/org/apache/nifi/nifi-kite-nar/${NIFI_KITE_NAR_VERSION}/nifi-kite-nar-${NIFI_KITE_NAR_VERSION}.nar -o ${NIFI_BASE_DIR}/lib/nifi-kite-nar-${NIFI_KITE_NAR_VERSION}.nar

# Download the Microsoft SQL Server JDBC driver and install it into the NiFi lib directory
RUN curl -fSL https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/${MSSQL_JDBC_VERSION}/mssql-jdbc-${MSSQL_JDBC_VERSION}.jar -o ${NIFI_BASE_DIR}/lib/mssql-jdbc-${MSSQL_JDBC_VERSION}.jar

RUN curl -fSL https://repo1.maven.org/maven2/org/apache/nifi/nifi-hive-nar/${NIFI_HIVE_NAR_VERSION}/nifi-hive-nar-${NIFI_HIVE_NAR_VERSION}.nar -o ${NIFI_BASE_DIR}/lib/nifi-hive-nar-${NIFI_HIVE_NAR_VERSION}.nar
RUN curl -fSL https://repo1.maven.org/maven2/org/apache/nifi/nifi-hive-services-api-nar/${NIFI_HIVE_NAR_VERSION}/nifi-hive-services-api-nar-${NIFI_HIVE_NAR_VERSION}.nar -o ${NIFI_BASE_DIR}/lib/nifi-hive-services-api-nar-${NIFI_HIVE_NAR_VERSION}.nar
RUN curl -fSL https://repo1.maven.org/maven2/org/apache/nifi/nifi-hive3-nar/${NIFI_HIVE_NAR_VERSION}/nifi-hive3-nar-${NIFI_HIVE_NAR_VERSION}.nar -o ${NIFI_BASE_DIR}/lib/nifi-hive3-nar-${NIFI_HIVE_NAR_VERSION}.nar