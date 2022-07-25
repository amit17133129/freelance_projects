ARG BASE_IMAGE=ubuntu
FROM $BASE_IMAGE

LABEL maintainer="dc-deployments@atlassian.com"
LABEL securitytxt="https://www.atlassian.com/.well-known/security.txt"

ENV APP_NAME                                        confluence
ENV RUN_USER                                        confluence
ENV RUN_GROUP                                       confluence
ENV RUN_UID                                         2002
ENV RUN_GID                                         2002


# https://confluence.atlassian.com/doc/confluence-home-and-other-important-directories-590259707.html
ENV CONFLUENCE_HOME                                 /var/atlassian/application-data/confluence
ENV CONFLUENCE_INSTALL_DIR                          /opt/atlassian/confluence

ENV CONFLUENCE_LOG_STDOUT                           false

# environmental variable for rds. use the password that is create in the database. I have deleted my test passwrd
# WE can pass the en variables from outside the container. but if we chose to pass it it inside the container, then it's okCLEAR
#ENV ATL_JDBC_URL confluence.cs0hbzi9hs84.us-gov-west-1.rds.amazonaws.com
#ENV ATL_JDBC_USER edu
#ENV ATL_JDBC_PASSWORD ""
#ENV ATL_DB_TYPE postgresql

WORKDIR $CONFLUENCE_HOME

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y openjdk-8-jre
RUN update-alternatives --config java
RUN update-alternatives --config javac

# Expose HTTP and Synchrony ports
EXPOSE 8090
EXPOSE 8091

CMD ["/entrypoint.py"]
ENTRYPOINT ["/usr/bin/tini", "--", "python3", "/entrypoint.py"]

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl \
    && apt-get install -y --no-install-recommends fontconfig fonts-noto python3 python3-jinja2 tini \
    && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ARG CONFLUENCE_VERSION
ARG DOWNLOAD_URL=https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-7.13.7.tar.gz

ENV CONFLUENCE_VERSION                              ${CONFLUENCE_VERSION}

RUN groupadd --gid ${RUN_GID} ${RUN_GROUP} \
    && useradd --uid ${RUN_UID} --gid ${RUN_GID} --home-dir ${CONFLUENCE_HOME} --shell /bin/bash ${RUN_USER} \
    && echo PATH=$PATH > /etc/environment \
    \
    && mkdir -p                                     ${CONFLUENCE_INSTALL_DIR} \
    && curl -L --silent                             ${DOWNLOAD_URL} | tar -xz --strip-components=1 -C "${CONFLUENCE_INSTALL_DIR}" \
    && chmod -R "u=rwX,g=rX,o=rX"                   ${CONFLUENCE_INSTALL_DIR}/ \
    && chown -R root.                               ${CONFLUENCE_INSTALL_DIR}/ \
    && chown -R ${RUN_USER}:${RUN_GROUP}            ${CONFLUENCE_INSTALL_DIR}/logs \
    && chown -R ${RUN_USER}:${RUN_GROUP}            ${CONFLUENCE_INSTALL_DIR}/temp \
    && chown -R ${RUN_USER}:${RUN_GROUP}            ${CONFLUENCE_INSTALL_DIR}/work \
    && chown -R ${RUN_USER}:${RUN_GROUP}            ${CONFLUENCE_HOME} \
    \
    && sed -i -e 's/-Xms\([0-9]\+[kmg]\) -Xmx\([0-9]\+[kmg]\)/-Xms\${JVM_MINIMUM_MEMORY:=\1} -Xmx\${JVM_MAXIMUM_MEMORY:=\2} -Dconfluence.home=\${CONFLUENCE_HOME}/g' ${CONFLUENCE_INSTALL_DIR}/bin/setenv.sh \
    && sed -i -e 's/-XX:ReservedCodeCacheSize=\([0-9]\+[kmg]\)/-XX:ReservedCodeCacheSize=${JVM_RESERVED_CODE_CACHE_SIZE:=\1}/g' ${CONFLUENCE_INSTALL_DIR}/bin/setenv.sh \
    && sed -i -e 's/export CATALINA_OPTS/CATALINA_OPTS="\${CATALINA_OPTS} \${JVM_SUPPORT_RECOMMENDED_ARGS} -DConfluenceHomeLogAppender.disabled=${CONFLUENCE_LOG_STDOUT}"\n\nexport CATALINA_OPTS/g' ${CONFLUENCE_INSTALL_DIR}/bin/setenv.sh \
    \
    && mkdir -p /opt/java/openjdk/lib/fonts/fallback/ \
    && ln -sf /usr/share/fonts/truetype/noto/* /opt/java/openjdk/lib/fonts/fallback/

VOLUME ["${CONFLUENCE_HOME}"] # Must be declared after setting perms

COPY entrypoint.py \
     shutdown-wait.sh \
     shared-components/image/entrypoint_helpers.py  /

RUN chmod +x /entrypoint.py 

COPY shared-components/support                      /opt/atlassian/support
COPY config/*                                       /opt/atlassian/etc/