# Start from a Java image.
FROM java:8

# Ignite version
ENV IGNITE_VERSION 1.7.0

# Ignite home
ENV IGNITE_HOME /opt/ignite/apache-ignite-fabric-${IGNITE_VERSION}-bin

# Do not rely on anything provided by base image(s), but be explicit, if they are installed already it is noop then
RUN apt-get update && apt-get install -y --no-install-recommends \
        unzip \
        curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/ignite

RUN curl http://www.us.apache.org/dist/ignite/${IGNITE_VERSION}/apache-ignite-fabric-${IGNITE_VERSION}-bin.zip -o ignite.zip \
    && unzip ignite.zip \
    && rm ignite.zip

# Copy sh files and set permission
COPY ./run.sh $IGNITE_HOME/
COPY ./config.xml $IGNITE_HOME/config/

RUN chmod +x $IGNITE_HOME/run.sh
RUN cp -r $IGNITE_HOME/libs/optional/ignite-aws $IGNITE_HOME/libs

CMD $IGNITE_HOME/run.sh

EXPOSE 11211 47100 47500 49112