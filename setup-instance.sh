#!/bin/bash

cd /home/ubuntu

sudo apt update && sudo apt upgrade -y >> /tmp/startup.log
curl -fsSL https://get.docker.com -o | sudo sh >> /tmp/startup.log
sudo usermod -aG docker ubuntu >> /tmp/startup.log
sudo apt install docker-compose -y >> /tmp/startup.log

echo "version: '3.6'
services:
  wireguard:
    container_name: wireguard
    hostname: wireguard
    image: linuxserver/wireguard:latest
    restart: unless-stopped
    environment:
      - PUID=1000
      - GUID=1000
      - TZ=UTC
      - SERVERPORT=51820
      - PEERS=6
      - ALLOWEDIPS=0.0.0.0/0
    ports:
      - 51820:51820/udp
    volumes:
      - ./config:/config
      - /lib/modules:/lib/modules
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
" > /home/ubuntu/docker-compose.yml

sudo docker-compose up -d >> /tmp/startup.log
