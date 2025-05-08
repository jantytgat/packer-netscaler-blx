#!/bin/sh
eval $(op signin)
cd linux/ubuntu-blx-22.04

git log -n 1 > build.auto.proxmox.data

op inject -i build.pkrvars.hcl -o build.auto.pkrvars.hcl
packer build -timestamp-ui .
