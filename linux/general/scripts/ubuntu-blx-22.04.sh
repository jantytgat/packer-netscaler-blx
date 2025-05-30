#!/bin/sh
SCRIPT_PATH="$1"

echo "########################################################################"
echo "UBUNTU 22.04 MINIMAL SERVER TEMPLATE"
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Update system"
echo "------------------------------------------------------------------------"
sh $SCRIPT_PATH/os/distro/debian-based/generic/apt/apt-update.sh
sh $SCRIPT_PATH/os/distro/debian-based/generic/apt/apt-configure.sh
sh $SCRIPT_PATH/os/distro/debian-based/generic/apt/apt-upgrade.sh
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Configure package sources"
echo "------------------------------------------------------------------------"
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Install additional packages"
echo "------------------------------------------------------------------------"
# sh $SCRIPT_PATH/software/apparmor/apt-install_apparmor-profiles.sh
# sh $SCRIPT_PATH/software/apparmor/apt-install_apparmor-utils.sh
sh $SCRIPT_PATH/software/bash/apt-install_bash-completion.sh
sh $SCRIPT_PATH/software/bind9/apt-install_bind9-dnsutils.sh
sh $SCRIPT_PATH/software/ca-certificates/apt-install.sh
sh $SCRIPT_PATH/software/cloud-init/apt-install.sh
sh $SCRIPT_PATH/software/cron/apt-install.sh
sh $SCRIPT_PATH/software/curl/apt-install.sh
# sh $SCRIPT_PATH/software/fail2ban/apt-install.sh
sh $SCRIPT_PATH/software/gnupg2/apt-install.sh
sh $SCRIPT_PATH/software/htop/apt-install.sh
sh $SCRIPT_PATH/software/inetutils/apt-install_inetutils-ping.sh
sh $SCRIPT_PATH/software/inetutils/apt-install_inetutils-traceroute.sh
sh $SCRIPT_PATH/software/itop/apt-install.sh
sh $SCRIPT_PATH/software/iperf3/apt-install.sh
sh $SCRIPT_PATH/software/nano/apt-install.sh
sh $SCRIPT_PATH/software/net-tools/apt-install.sh
# sh $SCRIPT_PATH/software/screen/apt-install.sh
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Execute template base configuration scripts"
echo "------------------------------------------------------------------------"
sh $SCRIPT_PATH/os/generic/grub/net-ifnames.sh
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Execute template hardening scripts"
echo "------------------------------------------------------------------------"
# sh $SCRIPT_PATH/os/generic/security/hardening/apparmor/enforce-ping.sh
# sh $SCRIPT_PATH/os/generic/security/hardening/etc/fail2ban.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/fstab.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/host.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/irqbalance.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/issue.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/modprobe.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/motd.sh
sh $SCRIPT_PATH/os/generic/security/hardening/etc/sysctl.sh
# sh $SCRIPT_PATH/os/generic/security/hardening/iptables/iptables_default.sh eth0
sh $SCRIPT_PATH/os/generic/security/hardening/ssh/sshd_config.sh
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Template cleanup"
echo "------------------------------------------------------------------------"
sh $SCRIPT_PATH/os/generic/crontab/cleanup-user.sh root
sh $SCRIPT_PATH/os/generic/crontab/cleanup-user.sh $PROVISIONER_USERNAME
sh $SCRIPT_PATH/os/generic/cloud-init/cleanup.sh
sh $SCRIPT_PATH/os/distro/debian-based/generic/apt/apt-autoremove.sh
sh $SCRIPT_PATH/os/distro/debian-based/generic/apt/apt-autoclean.sh
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo "### Remove Provisioner User"
echo "------------------------------------------------------------------------"
sh $SCRIPT_PATH/os/generic/security/users/remove_provisioner_user.sh $PROVISIONER_USERNAME
echo "########################################################################"
echo ""
echo ""
sleep 2s

echo " "
echo "########################################################################"
echo "UBUNTU 22.04 MINIMAL SERVER TEMPLATE - COMPLETED"
echo "########################################################################"
