resource "ibm_is_instance_template" "web_template" {
  name = "web_template"
  image = data.ibm_is_image.ubuntu_image.id
  profile = "cx2-2x4"
  keys = [ibm_is_ssh_key.ssh_key.id]
  resource_group = data.ibm_resource_group.default.id


  primary_network_interface{
    subnet = ibm_is_subnet.ecommmerce_subnet.id
  }
}

resource "ibm_is_auto_scale_group" "web_asg" {
  name = "web-asg"
  instance_template = ibm_is_instance_template.web_template.id
  subnets = [ibm_is_subnet.ecommmerce_subnet.id]
  min_members = 2
  max_members = 5
  cooldown = 300
}