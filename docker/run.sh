mkdir -p fio_output
docker run -it --rm -v $HOME/.ssh:/home/docker/.ssh -v $PWD/fio_output:/s3fs-scale-tests/fio_output s3fs-wassh:centos7 bash
