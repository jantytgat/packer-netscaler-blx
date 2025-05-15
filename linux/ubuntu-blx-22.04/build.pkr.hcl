packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}


build {
    name = "proxmox-ubuntu-blx-22-04"
    
    sources = ["source.proxmox-iso.ubuntu-blx-22-04"]

    provisioner "file" {
        source = "../general/scripts"
        destination = "/tmp/scripts"
    }

    provisioner "shell" {
        execute_command = "sudo -S -E bash -c '{{ .Vars }} {{ .Path }}'"
        environment_vars = [
            "PROVISIONER_USERNAME=${var.ssh_provisioner.username}",
        ]
        inline = [
            "git clone ${var.template_script_repository_url} /root/${var.template_script_repository_name}",
            "sh /tmp/scripts/ubuntu-blx-22.04.sh /root/${var.template_script_repository_name}/linux",
            "sh /root/${var.template_script_repository_name}/linux/software/netscaler/blx/apt-install.sh ${var.blx_install.base_url} ${var.blx_install.version} ${var.blx_install.build}",
        ]
    }
}

source "proxmox-iso" "ubuntu-blx-22-04" {
    # PROXMOX CONNECTION DETAILS
    proxmox_url = "${var.proxmox_url}/api2/json"
    insecure_skip_tls_verify = var.proxmox_skip_certificate_validation
    username = "${var.proxmox_username}@pam"
    password = var.proxmox_password
    node = lower(var.proxmox_node)

    # INSTALLER ISO
    iso_file = "${var.proxmox_iso_storage_name}:iso/${var.proxmox_iso_filename}"
    iso_checksum = var.proxmox_iso_checksum
    unmount_iso = var.proxmox_unmount_iso

    # VM DETAILS
    vm_id = var.proxmox_vm_id
    vm_name = var.proxmox_vm_name
    // template_name = var.proxmox_template_name
    template_description = file("build.auto.proxmox.data")

    # CLOUD-INIT
    cloud_init = true
    cloud_init_storage_pool = var.proxmox_vm_storage_name

    http_bind_address = var.packer_http.ipaddress
    http_port_min = var.packer_http.port_min
    http_port_max = var.packer_http.port_max
    http_content = {
        "/meta-data" = file("cloud-init/proxmox/meta-data")
        "/user-data" = templatefile("cloud-init/proxmox/user-data", { "provisioner_username" = var.ssh_provisioner.username, "provisioner_password" = bcrypt(var.ssh_provisioner.password, 10), "provisioner_sshkey" = var.ssh_provisioner.sshkey})
    }

    boot_wait = "5s"
    boot_command = [
        "c",
        "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/' <enter>",
        "initrd /casper/<wait2s>initrd<enter>",
        "boot<wait><enter>"
    ]

    # VM CONFIGURATION
    os = var.proxmox_vm_os_type

    cpu_type = var.proxmox_vm_cpu_type
    sockets = var.proxmox_vm_cpu_sockets
    cores = var.proxmox_vm_cpu_cores
    memory = var.proxmox_vm_memory
    machine = var.proxmox_vm_machine

    vga {
        type = var.proxmox_vm_vga.type
    }

    network_adapters {
        model = var.proxmox_vm_network_adapter1.model
        bridge = var.proxmox_vm_network_adapter1.bridge
        vlan_tag = var.proxmox_vm_network_adapter1.vlan_tag
    }

    network_adapters {
        model = var.proxmox_vm_network_adapter2.model
        bridge = var.proxmox_vm_network_adapter2.bridge
        vlan_tag = var.proxmox_vm_network_adapter2.vlan_tag
    }

    scsi_controller = var.proxmox_vm_scsi_controller
    disks {
        type = var.proxmox_vm_disks.type
        disk_size = var.proxmox_vm_disks.disk_size
        storage_pool = var.proxmox_vm_disks.storage_pool
        format = var.proxmox_vm_disks.format

    }

    # SSH CONNECTION
    ssh_timeout = var.ssh_provisioner.timeout
    ssh_username = var.ssh_provisioner.username
    ssh_agent_auth = true
}