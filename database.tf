resource "ibm_database" "postgres" {
    name  = "ecommerce-db"
    plan = "standard"
    service = "databases-for-postgresql"
    location = var.region
    resource_group_id = data.ibm_resource_group.id

    adminpassword = "atiq123!"

    users{
        name = "admin"
        password = "atiq123!"
    }
  
}