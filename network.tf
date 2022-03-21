
resource oci_core_subnet forms-subnet {
  cidr_block     = "10.0.0.0/24"
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.forms-vcn.default_dhcp_options_id
  display_name    = "forms-subnet"
  dns_label       = "formssubnet"
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.forms-vcn.default_route_table_id
  security_list_ids = [
    oci_core_vcn.forms-vcn.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.forms-vcn.id
}

resource "oci_core_vcn" "forms-vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "${var.prefix}Vcn"
  dns_label      = "${var.prefix}vcn"
}

resource oci_core_default_dhcp_options Default-DHCP-Options-for-forms-vcn {
  compartment_id = var.compartment_ocid
  display_name     = "Default DHCP Options for forms-vcn"
  domain_name_type = "CUSTOM_DOMAIN"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.forms-vcn.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "forms-vcn.oraclevcn.com",
    ]
    type = "SearchDomain"
  }
}

resource oci_core_default_route_table Default-Route-Table-for-forms-vcn {
  compartment_id = var.compartment_ocid
  display_name = "Default Route Table for forms-vcn"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.forms-vcn.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.Internet-Gateway-forms-vcn.id
  }
}

resource oci_core_internet_gateway Internet-Gateway-forms-vcn {
  compartment_id = var.compartment_ocid
  display_name = "Internet Gateway forms-vcn"
  vcn_id = oci_core_vcn.forms-vcn.id
}

resource oci_core_default_security_list Default-Security-List-for-forms-vcn {
  compartment_id = var.compartment_ocid
  display_name = "Default Security List for forms-vcn"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol  = "all"
    stateless = "false"
  }
  freeform_tags = {
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
  ingress_security_rules {
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
  }
  manage_default_resource_id = oci_core_vcn.forms-vcn.default_security_list_id
}
