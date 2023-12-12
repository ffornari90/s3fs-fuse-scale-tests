mkdir -p 1_clients/sequential/read/1
mkdir -p 1_clients/sequential/read/2
mkdir -p 1_clients/sequential/read/3
mkdir -p 1_clients/sequential/write/1
mkdir -p 1_clients/sequential/write/2
mkdir -p 1_clients/sequential/write/3
mkdir -p 1_clients/random/1
mkdir -p 1_clients/random/2
mkdir -p 1_clients/random/3
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0 && fio --name=seqread --rw=read --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/read/1/"s3fs-client1-seq-read.log" 2>&1
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0 && fio --name=seqread --rw=read --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/read/2/"s3fs-client1-seq-read.log" 2>&1
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0 && fio --name=seqread --rw=read --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/read/3/"s3fs-client1-seq-read.log" 2>&1
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqread.0.0"
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0 && fio --name=seqwrite --rw=write --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/write/1/"s3fs-client1-seq-write.log" 2>&1
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0 && fio --name=seqwrite --rw=write --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/write/2/"s3fs-client1-seq-write.log" 2>&1
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0 && fio --name=seqwrite --rw=write --direct=1 --ioengine=libaio --bs=4M --size=1G --iodepth=64" > 1_clients/sequential/write/3/"s3fs-client1-seq-write.log" 2>&1
sleep 120
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f seqwrite.0.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0 && fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test-4m --filename=test-4m.0 --bs=4M --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75" > 1_clients/random/1/"s3fs-client1-rand-readwrite.log" 2>&1
sleep 120
grep read: 1_clients/random/1/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/1/"s3fs-client1-rand-read.log" 2>&1
grep write: 1_clients/random/1/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/1/"s3fs-client1-rand-write.log" 2>&1
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0 && fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test-4m --filename=test-4m.0 --bs=4M --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75" > 1_clients/random/2/"s3fs-client1-rand-readwrite.log" 2>&1
sleep 120
grep read: 1_clients/random/2/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/2/"s3fs-client1-rand-read.log" 2>&1
grep write: 1_clients/random/2/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/2/"s3fs-client1-rand-write.log" 2>&1
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0"
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0 && fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=test-4m --filename=test-4m.0 --bs=4M --iodepth=64 --size=1G --readwrite=randrw --rwmixread=75" > 1_clients/random/3/"s3fs-client1-rand-readwrite.log" 2>&1
sleep 120
grep read: 1_clients/random/3/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/3/"s3fs-client1-rand-read.log" 2>&1
grep write: 1_clients/random/3/"s3fs-client1-rand-readwrite.log" | awk '{gsub(/[IOPS=,(MB/s]/," "); print $2, $6}' > 1_clients/random/3/"s3fs-client1-rand-write.log" 2>&1
docker exec s3fs-client1 sh -c "cd /home/docker/mnt/rgw && rm -f test-4m.0"
docker stop s3fs-client1
docker rm s3fs-client1
