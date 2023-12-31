#!/bin/bash -x
if ! [[ $# -eq 3 ]] ; then
    echo 'ERROR: You must provide the correct number of parameters (client number, file size and block size in this order).'
    exit 0
fi
declare -a pids
CLI_NUM=$(($1 / 4))
FILE_SIZE=$2
BLOCK_SIZE=$3
for count in $(seq 1 3)
do
  mkdir -p /s3fs-scale-tests/fio_output/$1_clients/sequential/write/$count
  for ((index=0; index != $(($CLI_NUM * 4)); index=$(($index + 4)))); do
    wassh -f client-hosts -l root 'CLI_INDEX=$(expr '$(($index + 1))' + $CLIENT_X_FACTOR) && docker exec s3fs-client$CLI_INDEX sh -c "sleep 30 && cd /home/docker/mnt/rgw && rm -f seqwrite.0.0 && fio --name=seqwrite --rw=write --direct=1 --ioengine=libaio --bs="'$BLOCK_SIZE'" --size="'$FILE_SIZE'" --iodepth=64"' > /s3fs-scale-tests/fio_output/$1_clients/sequential/write/$count/"s3fs-client"$(($index + 1))"-seq-write.log" 2>&1 & pids+=($!)
  done
  for pid in "${pids[@]}"; do
    wait "$pid"
  done
  sleep 240
  pids=()
  for ((index=0; index != $(($CLI_NUM * 4)); index=$(($index + 4)))); do
    wassh -f client-hosts -l root 'CLI_INDEX=$(expr '$(($index + 1))' + $CLIENT_X_FACTOR) && docker exec s3fs-client$CLI_INDEX sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0"' & pids+=($!)
  done
  for pid in "${pids[@]}"; do
    wait "$pid"
  done
done
