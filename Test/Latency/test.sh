#!/bin/bash
set -e

echo "Avvio Test Ping Rete Bloccante"

docker exec -d clab-block-host2 iperf3 -s &
docker exec -d clab-block-host4 iperf3 -s &
docker exec -d clab-block-host6 iperf3 -s &
docker exec -d clab-block-host8 iperf3 -s &

sleep 2

docker exec clab-block-host1 iperf3 -c 10.0.0.22 -t 40 -P 5 > /dev/null 2>&1 &
docker exec clab-block-host3 iperf3 -c 10.0.0.30 -t 40 -P 5 > /dev/null 2>&1 &
docker exec clab-block-host5 iperf3 -c 10.0.0.6  -t 40 -P 5 > /dev/null 2>&1 &
docker exec clab-block-host7 iperf3 -c 10.0.0.14 -t 40 -P 5 > /dev/null 2>&1 &

sleep 2

docker exec clab-block-host1 ping -c 30 10.0.0.26 > ./Blocking/ping_H1_H7.txt 2>&1 &
docker exec clab-block-host2 ping -c 30 10.0.0.18 > ./Blocking/ping_H2_H5.txt 2>&1 &
docker exec clab-block-host3 ping -c 30 10.0.0.22 > ./Blocking/ping_H3_H6.txt 2>&1 &
docker exec clab-block-host4 ping -c 30 10.0.0.30 > ./Blocking/ping_H4_H8.txt 2>&1 &
docker exec clab-block-host5 ping -c 30 10.0.0.2  > ./Blocking/ping_H5_H1.txt 2>&1 &
docker exec clab-block-host6 ping -c 30 10.0.0.6  > ./Blocking/ping_H6_H2.txt 2>&1 &
docker exec clab-block-host7 ping -c 30 10.0.0.10 > ./Blocking/ping_H7_H3.txt 2>&1 &
docker exec clab-block-host8 ping -c 30 10.0.0.14 > ./Blocking/ping_H8_H4.txt 2>&1 &

wait

sleep 5

echo "Avvio dei test iperf3 e ping sulla rete leaf-spine..."

docker exec -d clab-leafspine-host2 iperf3 -s &
docker exec -d clab-leafspine-host4 iperf3 -s &
docker exec -d clab-leafspine-host6 iperf3 -s &
docker exec -d clab-leafspine-host8 iperf3 -s &

sleep 2

docker exec clab-leafspine-host1 iperf3 -c 10.0.0.22 -t 30 -P 5 > /dev/null 2>&1 &
docker exec clab-leafspine-host3 iperf3 -c 10.0.0.30 -t 30 -P 5 > /dev/null 2>&1 &
docker exec clab-leafspine-host5 iperf3 -c 10.0.0.6  -t 30 -P 5 > /dev/null 2>&1 &
docker exec clab-leafspine-host7 iperf3 -c 10.0.0.14 -t 30 -P 5 > /dev/null 2>&1 &

sleep 2

docker exec clab-leafspine-host1 ping -c 30 10.0.0.26 > ./Leaf-Spine/ping_H1_H7.txt 2>&1 &
docker exec clab-leafspine-host2 ping -c 30 10.0.0.18 > ./Leaf-Spine/ping_H2_H5.txt 2>&1 &
docker exec clab-leafspine-host3 ping -c 30 10.0.0.22 > ./Leaf-Spine/ping_H3_H6.txt 2>&1 &
docker exec clab-leafspine-host4 ping -c 30 10.0.0.30 > ./Leaf-Spine/ping_H4_H8.txt 2>&1 &
docker exec clab-leafspine-host5 ping -c 30 10.0.0.2  > ./Leaf-Spine/ping_H5_H1.txt 2>&1 &
docker exec clab-leafspine-host6 ping -c 30 10.0.0.6  > ./Leaf-Spine/ping_H6_H2.txt 2>&1 &
docker exec clab-leafspine-host7 ping -c 30 10.0.0.10 > ./Leaf-Spine/ping_H7_H3.txt 2>&1 &
docker exec clab-leafspine-host8 ping -c 30 10.0.0.14 > ./Leaf-Spine/ping_H8_H4.txt 2>&1 &

wait

echo "Test completati. Risultati salvati."

