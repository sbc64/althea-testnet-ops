#!/usr/bin/env bash

cat -> /tmp/compose.yml <<EOF
version: '3'

services:
  gaiadnode0:
    container_name: sentrynode1 
    image: $container
    ports:
      - "26656-26657:26656-26657"
    environment:
      - ID=0
      - LOG=$${LOG:-gaiad.log}
    volumes:
      - ./build:/gaiad:Z
    networks:
      localnet:
        ipv4_address: 192.168.10.2

  gaiadnode1:
    container_name: gaiadnode1
    image: "tendermint/gaiadnode"
    ports:
      - "26659-26660:26656-26657"
    environment:
      - ID=1
      - LOG=$${LOG:-gaiad.log}
    volumes:
      - ./build:/gaiad:Z
    networks:
      localnet:
        ipv4_address: 192.168.10.3

  gaiadnode2:
    container_name: gaiadnode2
    image: "tendermint/gaiadnode"
    environment:
      - ID=2
      - LOG=$${LOG:-gaiad.log}
    ports:
      - "26661-26662:26656-26657"
    volumes:
      - ./build:/gaiad:Z
    networks:
      localnet:
        ipv4_address: 192.168.10.4

  gaiadnode3:
    container_name: gaiadnode3
    image: "tendermint/gaiadnode"
    environment:
      - ID=3
      - LOG=$${LOG:-gaiad.log}
    ports:
      - "26663-26664:26656-26657"
    volumes:
      - ./build:/gaiad:Z
    networks:
      localnet:
        ipv4_address: 192.168.10.5

networks:
  localnet:
    driver: bridge
    ipam:
      driver: default
      config:
      -
        subnet: 192.168.10.0/16
EOF
