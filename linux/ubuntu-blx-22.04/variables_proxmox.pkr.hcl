# Configure Packer HTTP Server for serving cloud-init data
variable "packer_http" {
    type = object({
        ipaddress = string
        port_min = number
        port_max = number
    })
    default = {
        ipaddress = null
        port_min = 40100
        port_max = 40199
    }
}

# Proxmox URL, http(s)://<fqdn>|<ip>
variable "proxmox_url" {
    type = string
    description = "URL or IP Address of the Proxmox API, without a HTTP PATH"
    sensitive = false
}

# Proxmox API port
variable "proxmox_port" {
    type = number
    default = 8006
    description = "Port on which the Proxmox API listens"
    sensitive = false
}

# Check certificate validaty of the Proxmox API
variable "proxmox_skip_certificate_validation" {
    type = bool
    default = false
    description = "Skip SSL certificate validation when connecting to the Proxmox API"
    sensitive = false
}

# Proxmox provisioning user name
variable "proxmox_username" {
    type = string
    default = "root@pam"
    description = "Proxmox API Username"
    sensitive = true
}

# Proxmox provisioning user password
variable "proxmox_password" {
    type = string
    description = "Proxmox API Password"
    sensitive = true
}

# Name of the Proxmox node in the cluster to run the provisioning process
variable "proxmox_node" {
    type = string
    description = "Proxmox Node Name that will run the build"
    sensitive = false
}

# Storage name for the ISO file
variable "proxmox_iso_storage_name" {
    type = string
    default = "local"
    description = "Name of the storage repository where the ISO-file can be found"
    sensitive = false
}

# Name of the ISO file
variable "proxmox_iso_filename" {
    type = string
    description = "Filename of the ISO-file"
    sensitive = false
}

# Checksum for the ISO file
variable "proxmox_iso_checksum" {
    type = string
    description = "Checksum for the ISO file"
    sensitive = false
}

# Unmount the ISO file when building is complete
variable "proxmox_unmount_iso" {
    type = bool
    default = true
    description = "Unmount the ISO-file when building is complete"
    sensitive = false
}

variable "proxmox_vm_name" {
    type = string
    default = "packer-ubuntu-22-04"
    description = "Virtual machine name while Packer is running"
    sensitive = false
}

variable "proxmox_vm_id" {
    type = number
    default = 899999001
    description = "Virtual machine ID"
}

variable "proxmox_vm_storage_name" {
    type = string
    description = "Name of the storage pool to store the virtual machine"
    sensitive = false
}


variable "proxmox_cloudinit_path" {
    type = string
    default = "cloud-init/proxmox"
    description = "Path to mount the cloud-init files into the HTTP server"
    sensitive = false
}


variable "proxmox_vm_os_type" {
    type = string
    default = "l26"
    description = "Virtual machine type"
    sensitive = false
}

variable "proxmox_vm_cpu_type" {
    type = string
    default = "x86-64-v2-AES"
    description = "Virtual machine processor type"
    sensitive = false
}

variable "proxmox_vm_cpu_sockets" {
    type = number
    default = 1
    description = "Virtual machine CPU sockets"
    sensitive = false
}

variable "proxmox_vm_cpu_cores" {
    type = number
    default = 4
    description = "Virtal machine CPU cores"
    sensitive = false
}

variable "proxmox_vm_memory" {
    type = number
    default = 8192
    description = "Virtual machine memory"
    sensitive = false
}

variable "proxmox_vm_machine" {
    type = string
    default = "q35"
    description = "Virtual machine type"
    sensitive = false
}

variable "proxmox_vm_vga" {
    type = object({
        type = string
        memory = number
    })
    default = {
        type = "virtio"
        memory = null
    }
}

variable "proxmox_vm_network_adapter1" {
    type = object({
        model = string
        bridge = string
        vlan_tag = number
    })
    default = {
            model = "virtio"
            bridge = ""
            vlan_tag = null
    }
}

variable "proxmox_vm_network_adapter2" {
    type = object({
        model = string
        bridge = string
        vlan_tag = number
    })
    default = {
            model = "virtio"
            bridge = "vmbr0"
            vlan_tag = null
    }
}

variable "proxmox_vm_scsi_controller" {
    type = string
    default = "virtio-scsi-single"
    description = "SCSI Controller model"
    sensitive = false
}

variable "proxmox_vm_disks" {
    type = object({
        type = string
        disk_size = string
        storage_pool = string
        format = string
    })
    default = {
            type = "virtio"
            disk_size = "50G"
            storage_pool = ""
            format = "qcow2"
    }
}

variable "ssh_provisioner" {
    type = object({
        timeout = string
        username = string
        password = string
        sshkey = string
    })
    default = {
        timeout = "5m"
        username = ""
        password = ""
        sshkey = ""
    }
    sensitive = true
}

variable "template_script_repository_url" {
    type = string
    default = "https://github.com/jantytgat/iac-scripts"
    description = "URL of the Git-repository containing all template scripts to configure the image"
    sensitive = false
}

variable "template_script_repository_name" {
    type = string
    default = "iac-scripts"
    description = "Name of the Git-repository containing all template scripts to configure the image"
    sensitive = false
}

variable "blx_install" {
    type = object({
        base_url = string
        version = string
        build = string
    })
}