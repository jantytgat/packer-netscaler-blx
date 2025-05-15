#!/bin/sh
INPUT=$1
eval $(op signin)
cd linux/ubuntu-blx-22.04

git log -n 1 > build.auto.proxmox.data

op inject -i $INPUT -o build.auto.pkrvars.hcl
PACKER_LOG="yes" PACKER_LOG_PATH="debug.log" packer build -timestamp-ui .
