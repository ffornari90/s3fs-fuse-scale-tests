FROM centos:7
ARG USER_UID
ARG USER_GID
RUN yum install -y epel-release && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    yum install -y git python3 rpm-build ssh-agent \
    make gcc perl-JSON docbook-utils perl-AppConfig \
    perl-IO-String perl-Proc-ProcessTable perl-Sys-Syslog && \
    yum clean all && rm -rf /var/cache/yum && \
    git clone https://gitlab.cern.ch/dss/wassh.git && \
    git clone https://baltig.infn.it/fornari/s3fs-scale-tests.git && \
    cd wassh && make rpm && rpm -ivh /wassh/build/RPMS/x86_64/*.rpm && \
    groupadd --system --gid $USER_GID docker && \
    adduser --system --uid $USER_UID \
    --gid $USER_GID --home /home/docker docker && \
    chown docker:docker -R /s3fs-scale-tests
USER docker
WORKDIR /s3fs-scale-tests
CMD bash
