#!/bin/bash
set -e

echo "Test di ping prima del link failure (Blocking)"

docker exec clab-block-host8 ping -c 5 10.0.0.14 > ./Blocking/ping_H1_H4_before.txt &
docker exec clab-block-host8 traceroute -w 5 10.0.0.14 > ./Blocking/traceroute_H1_H4_before.txt &

wait

echo "Interruzione del link (Blocking)"
docker exec clab-block-agg1 ip link set dev eth1 down

wait

echo "Test di ping dopo il link failure (Blocking)"

docker exec clab-block-host8 ping -c 5 10.0.0.14 > ./Blocking/ping_H1_H4_after.txt 2>&1 &
docker exec clab-block-host8 traceroute -w 5 10.0.0.14 > ./Blocking/traceroute_H1_H4_after.txt 2>&1 &

wait

echo "Ripristino collegamento (Blocking)"

docker exec clab-block-agg1 ip link set dev eth1 up

wait

echo "Test di ping prima del link failure (Leaf-Spine)"

docker exec clab-leafspine-host8 ping -c 5 10.0.0.14 > ./Leaf-Spine/ping_H1_H4_before.txt &
docker exec clab-leafspine-host8 traceroute -w 5 10.0.0.14 > ./Leaf-Spine/traceroute_H1_H4_before.txt &

wait

echo "Interruzione del link (Leaf-Spine)"
docker exec clab-leafspine-leaf2 ip link set dev eth1 down

wait

echo "Test di ping dopo il link failure (Leaf-Spine)"

docker exec clab-leafspine-host8 ping -c 5 -O 10.0.0.14 > ./Leaf-Spine/ping_H1_H4_after.txt 2>&1 &
wait
docker exec clab-leafspine-host8 traceroute -w 5 10.0.0.14 > ./Leaf-Spine/traceroute_H1_H4_after.txt 2>&1 &

wait

echo "Ripristino collegamento (Leaf-Spine)"

docker exec clab-leafspine-leaf2 ip link set dev eth1 up

wait

echo "Test Completato"
