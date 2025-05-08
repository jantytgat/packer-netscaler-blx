default:

ubuntu-blx-22-04:
	sh ./scripts/ubuntu-blx-22.04.sh
	sh ./scripts/cleanup.sh ./linux/ubuntu-blx-22.04

clean:
	sh ./scripts/cleanup.sh ./linux/ubuntu-blx-22.04