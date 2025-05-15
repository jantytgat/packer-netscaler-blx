proxmox_url = "{{ op://infrastructure/PVE001/website }}"
proxmox_skip_certificate_validation = true
proxmox_username = "{{ op://infrastructure/PVE001/username }}"
proxmox_password = "{{ op://infrastructure/PVE001/password }}"
proxmox_node = "{{ op://infrastructure/PVE001/Title }}"

proxmox_iso_storage_name = "local"
proxmox_iso_filename = "ubuntu-22.04.5-live-server-amd64.iso"
proxmox_iso_checksum = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"


proxmox_vm_name = "packer-ubuntu-blx-22-04"
proxmox_vm_storage_name = "local"

proxmox_vm_network_adapter1 = {
    model = "virtio"
    bridge = "vmbr0"
    vlan_tag = null
}

proxmox_vm_disks = {
    type = "virtio"
    disk_size = "50G"
    storage_pool = "local"
    format = "qcow2"
}


ssh_provisioner = {
    timeout = "60m"
    username = "{{ op://infrastructure/packer-stager/username }}"
    password = "{{ op://infrastructure/packer-stager/password }}"
    sshkey = "{{ op://Private/SSH Key - Jan/public key }}"
}

blx_install = {
    base_url = "https://downloads.corelayer.eu/citrix/netscaler"
    version = "14.1"
    build = "43.50"
}