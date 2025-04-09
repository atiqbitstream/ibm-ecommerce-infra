resource "ibm_database" "postgres" {
    name  = "ecommerce-db"
    plan = "standard"
    service = "databases-for-postgresql"
    location = var.region
    resource_group_id = data.ibm_resource_group.default.id
    service_endpoints = "public"

    adminpassword = "Aq7mF2z4W9pX8R1"

    users{
        name = "admin"
        password = "Aq7mF2z4W9pX8R1"
    }
  #extras
}