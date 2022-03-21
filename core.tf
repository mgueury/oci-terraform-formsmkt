#
# Terraform
# - Create a compute with the Forms Marketplace image.
# - Add autosetup files from terraforms and start the configuration automatically
#
# Author: marc.gueury@oracle.com
#

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = "1"
}

resource oci_core_instance forms1 {

  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id = var.compartment_ocid
  create_vnic_details {
    #assign_private_dns_record = <<Optional value not found in discovery>>
    assign_public_ip = "true"
    display_name = "forms1"
    hostname_label = "forms1"
    subnet_id = oci_core_subnet.forms-subnet.id
  }
  display_name = "forms1"

  metadata = {
    "ssh_authorized_keys" = var.ssh_public_key
  }
  shape = "VM.Standard.E4.Flex"
  shape_config {
    memory_in_gbs = "16"
    ocpus = "1"
  }
  source_details {
    boot_volume_size_in_gbs = "75"
    source_id = data.oci_marketplace_listing_package.forms_listing_package.image_id
    source_type = "image"
  }

  provisioner "file" {    
    connection {
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = var.ssh_private_key
      host        = oci_core_instance.forms1.*.public_ip[0]
    }
    source      = "file/.success"
    destination = "/u01/oracle/.frm_config/msg/.success"  
  }
  provisioner "file" {    
    connection {
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = var.ssh_private_key
      host        = oci_core_instance.forms1.*.public_ip[0]
    }
    source      = "file/.autosetup.ini"
    destination = "/u01/oracle/.autosetup.ini"  
  }
  provisioner "file" {    
    connection {
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = var.ssh_private_key
      host        = oci_core_instance.forms1.*.public_ip[0]
    }
    source      = "file/.autosetup.json"
    destination = "/u01/oracle/.autosetup.json"  
  }  
  provisioner "file" {    
    connection {
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = var.ssh_private_key
      host        = oci_core_instance.forms1.*.public_ip[0]
    }
    source      = "file/domainconfig.sh"
    destination = "/u01/oracle/.frm_config/domainconfig.sh"  
  }

  provisioner "remote-exec" {    
    connection {
      agent       = false
      timeout     = "5m"
      user        = "opc"
      private_key = var.ssh_private_key
      host        = oci_core_instance.forms1.*.public_ip[0]
    }
    inline = [
      "sh /u01/oracle/.frm_config/domainconfig.sh"
    ]

  }
}

output "build_public_ip" {
  value = [oci_core_instance.forms1.*.public_ip]
}
