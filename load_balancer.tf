resource "ibm_is_lb" "web_lb" {
    name = "web-lb"
    subnets = [ibm_is_subnet.ecommmerce_subnet.id]
    type = "public"
  
}

resource "ibm_is_lb_pool" "web_pool" {
  name = "web_pool"
  lb = ibm_is_lb.web_lb.id
  algorithm = "round_robin"
  protocol = "http"
  health_delay = 5
  health_retries = 2
  health_type = "http"
  health_monitor_url = "/"
}

resource "ibm_is_lb_pool_member" "web_members" {
  count = 2
  lb = ibm_is_lb.web_lb.id
  pool = ibm_is_lb_pool.web_pool.pool_id
  port = 80
  target = ibm_is_auto_scale_group.web_asg.id
}