resource "ibm_is_instance_template" "web_template" {
  name = "web_template"
  image = data.ibm_is_image.ubuntu_image.id
  profile = "cx2-2x4"
  keys = [ibm_is_ssh_key.ssh_key.id]
  resource_group = data.ibm_resource_group.default.id
  zone = "${var.region}-1"
  vpc = ibm_is_vpc.ecommerce_vpc.id


  primary_network_interface{
    subnet = ibm_is_subnet.ecommmerce_subnet.id
  }
}

resource "ibm_is_instance_group" "web_asg" {
  name = "web-asg"
  instance_template = ibm_is_instance_template.web_template.id
  subnets = [ibm_is_subnet.ecommmerce_subnet.id]
  instance_count = 2
  resource_group = data.ibm_resource_group.default.id
}

resource "ibm_is_instance_group_manager" "web_asg_manager" {
    name = "web-asg-manager"
    instance_group = ibm_is_instance_group.web_asg.id
    aggregation_window = 120
    cooldown = 300
    manager_type = "autoscale"
    enable_manager = true
    max_membership_count = 5
    min_membership_count = 2
 
}