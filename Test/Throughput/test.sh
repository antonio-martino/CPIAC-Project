#!/bin/bash
set -e

echo "Avvio dei test iperf3 sulla rete bloccante..."

docker exec -d clab-block-host2 iperf3 -s &
docker exec -d clab-block-host4 iperf3 -s &
docker exec -d clab-block-host6 iperf3 -s &
docker exec -d clab-block-host8 iperf3 -s &

sleep 2

docker exec clab-block-host1 iperf3 -c 10.0.0.22 -t 10 -P 5 > ./Blocking/result_H1_H6.txt &
docker exec clab-block-host3 iperf3 -c 10.0.0.30 -t 10 -P 5 > ./Blocking/result_H3_H8.txt &
docker exec clab-block-host5 iperf3 -c 10.0.0.6  -t 10 -P 5 > ./Blocking/result_H5_H2.txt &
docker exec clab-block-host7 iperf3 -c 10.0.0.14 -t 10 -P 5 > ./Blocking/result_H7_H4.txt &

wait

echo "Avvio dei test iperf3 sulla rete leaf-spine..."

docker exec -d clab-leafspine-host2 iperf3 -s &
docker exec -d clab-leafspine-host4 iperf3 -s &
docker exec -d clab-leafspine-host6 iperf3 -s &
docker exec -d clab-leafspine-host8 iperf3 -s &

sleep 2

docker exec clab-leafspine-host1 iperf3 -c 10.0.0.22 -t 10 -P 5 > ./Leaf-Spine/result_H1_H6.txt &
docker exec clab-leafspine-host3 iperf3 -c 10.0.0.30 -t 10 -P 5 > ./Leaf-Spine/result_H3_H8.txt &
docker exec clab-leafspine-host5 iperf3 -c 10.0.0.6  -t 10 -P 5 > ./Leaf-Spine/result_H5_H2.txt &
docker exec clab-leafspine-host7 iperf3 -c 10.0.0.14 -t 10 -P 5 > ./Leaf-Spine/result_H7_H4.txt &

wait

echo "Test completati. Risultati salvati."
