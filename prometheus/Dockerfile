FROM centos:centos7

# Define Prometheus home and its version
ARG PROMETHEUS_HOME=/opt/prometheus
ARG PROMETHEUS_VERSION=2.0.0

# Define TAR & folder names, as well as download URL for easier use
ARG PROMETHEUS_TAR_MAYOR=prometheus-${PROMETHEUS_VERSION}.linux-amd64
ARG PROMETHEUS_TAR_FULLNAME=${PROMETHEUS_TAR_MAYOR}.tar.gz
ARG PROMETHEUS_URL=https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${PROMETHEUS_TAR_FULLNAME}

# Update yum and install wget; download Prometheus
RUN yum update -y && \
    yum install -y wget && \
    wget ${PROMETHEUS_URL}

# Untar the file and rename it to "prometheus"
RUN tar xvfz ${PROMETHEUS_TAR_FULLNAME} -C /opt && \
    mv /opt/${PROMETHEUS_TAR_MAYOR} /opt/prometheus && \
    rm -rf /opt/prometheus/prometheus.yml

RUN groupadd -r prometheus && \
    useradd -g prometheus -s /bin/bash -c "Prometheus user" prometheus && \
    chown -R prometheus:prometheus /opt/prometheus

COPY config/prometheus.yml /opt/prometheus/prometheus.yml

RUN chown prometheus:prometheus /opt/prometheus/prometheus.yml && \
    chmod 755 /opt/prometheus/prometheus.yml

EXPOSE 9090
VOLUME  [ "/opt/prometheus" ]
WORKDIR ${PROMETHEUS_HOME}

USER prometheus

ENTRYPOINT [ "./prometheus" ]
CMD        [ "--config.file=prometheus.yml" ]
