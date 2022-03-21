# DATA 1 - Get a list of element in Marketplace, using filters, eg name of the stack
data "oci_marketplace_listings" "forms_listings" {
  name = ["Oracle Forms Services"]
  compartment_id = var.compartment_ocid
}

# DATA 2 - Get details cf the specific listing you are interested in and which you obtained through generic listing
data "oci_marketplace_listing" "forms_listing" {
  listing_id     = data.oci_marketplace_listings.forms_listings.listings[0].id
  compartment_id = var.compartment_ocid
}

# DATA 3 - Get the list of versions for the specific entry (11.3, 12.2.1, ....)
data "oci_marketplace_listing_packages" "forms_listing_packages" {
  #Required
  listing_id = data.oci_marketplace_listing.forms_listing.id

  #Optional
  compartment_id = var.compartment_ocid
  package_version = data.oci_marketplace_listing.forms_listing.default_package_version
}

# DATA 4 - Get details about a specfic version
data "oci_marketplace_listing_package" "forms_listing_package" {
  #Required
  listing_id      = data.oci_marketplace_listing.forms_listing.id
  package_version = data.oci_marketplace_listing_packages.forms_listing_packages.package_version

  #Optional
  compartment_id = var.compartment_ocid
}

# DATA 5 - agreement for a specific version
data "oci_marketplace_listing_package_agreements" "forms_listing_package_agreements" {
  #Required
  listing_id      = data.oci_marketplace_listing.forms_listing.id
  package_version = data.oci_marketplace_listing_packages.forms_listing_packages.package_version

  #Optional
  compartment_id = var.compartment_ocid
}

# RESOURCE 1 - agreement for a specific version
resource "oci_marketplace_listing_package_agreement" "forms_listing_package_agreement" {
  #Required
  agreement_id    = data.oci_marketplace_listing_package_agreements.forms_listing_package_agreements.agreements[0].id
  listing_id      = data.oci_marketplace_listing.forms_listing.id
  package_version = data.oci_marketplace_listing_packages.forms_listing_packages.package_version
}

# RESOURCE 2 - Accepted agreement
resource "oci_marketplace_accepted_agreement" "forms_accepted_agreement" {
  #Required
  agreement_id    = oci_marketplace_listing_package_agreement.forms_listing_package_agreement.agreement_id
  compartment_id  = var.compartment_ocid
  listing_id      = data.oci_marketplace_listing.forms_listing.id
  package_version = data.oci_marketplace_listing_packages.forms_listing_packages.package_version
  signature       = oci_marketplace_listing_package_agreement.forms_listing_package_agreement.signature
}

output "image_id" {
  value = [data.oci_marketplace_listing_package.forms_listing_package.image_id]
}
