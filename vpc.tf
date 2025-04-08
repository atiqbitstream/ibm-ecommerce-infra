resource "ibm_is_vpc" "ecommerce_vpc" {
  name = "ecommerce-vpc"
  resource_group= data.ibm_resource_group.default.id
}

data "ibm_resource_group" "default" {
  name = "Default"
}

data "ibm_is_image" "ubuntu_image" {
    name = "ibm-ubuntu-22-04-5-minimal-amd64-2"
  
}

resource "ibm_is_subnet" "ecommmerce_subnet" {
  name = "ecommerce-subnet"
  vpc = ibm_is_vpc.ecommerce_vpc.id
  zone = "${var.region}-1"
  total_ipv4_address_count = 256
}

resource "ibm_is_ssh_key" "ssh_key" {
    name = "web-server-ssh"
    public_key = "${var.ssh_public_key}"
  
}

resource "ibm_is_instance" "web_server" {
  name = "web-server-1"
  vpc = ibm_is_vpc.ecommerce_vpc.id
  zone = "${var.region}-1"
  keys = [ibm_is_ssh_key.ssh_key.id]
  image = data.ibm_is_image.ubuntu_image.id
  profile = "cx2-2x4"
  resource_group = data.ibm_resource_group.default.id

  primary_network_interface{
    subnet = ibm_is_subnet.ecommmerce_subnet.id
  }
}