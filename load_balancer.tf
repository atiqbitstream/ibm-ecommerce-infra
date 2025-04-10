resource "ibm_is_lb" "web_lb" {
    name = "web-lb"
    subnets = [ibm_is_subnet.ecommmerce_subnet.id]
    type = "public"

    # timeouts{
    #   create = "20m"
    #   delete = "10m"
    # }
  
}

resource "ibm_is_lb_pool" "web_pool" {
  name = "web-pool"
  lb = ibm_is_lb.web_lb.id
  algorithm = "round_robin"
  protocol = "http"
  health_delay = 5
  health_retries = 2
  health_timeout = 2
  health_type = "http"
  health_monitor_url = "/"

  # timeouts {
  #   create = "15m"
  # }
}
#extras
resource "ibm_is_lb_listener" "web_listener" {
  lb = ibm_is_lb.web_lb.id
  port = 80
  protocol = "http"
  default_pool = ibm_is_lb_pool.web_pool.id
}

resource "ibm_is_lb_pool_member" "web_asg_member" {

  lb = ibm_is_lb.web_lb.id
  pool = ibm_is_lb_pool.web_pool.id
  port = 80
  target_id = ibm_is_instance_group.web_asg.id

  depends_on = [ 
    ibm_is_instance_group.web_asg,
    ibm_is_lb_pool.web_pool
   ]
  
}

