docker build --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g) -t s3fs-wassh:centos7 .
