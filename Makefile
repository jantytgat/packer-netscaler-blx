default:

ubuntu-blx-22-04:
	packer init "./linux/ubuntu-blx-22.04"
	sh ./scripts/ubuntu-blx-22.04.sh build.pkrvars.hcl
	sh ./scripts/cleanup.sh ./linux/ubuntu-blx-22.04

clean:
	sh ./scripts/cleanup.sh ./linux/ubuntu-blx-22.04