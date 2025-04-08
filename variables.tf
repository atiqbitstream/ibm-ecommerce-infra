variable "ibmcloud_api_key"{
  description = "IBM Cloud API Key"
  type = string
  sensitive = true
}

variable "ssh_public_key"{
  description = "The public SSH Key for accessing the instance"
  type = string
  sensitive = true
}


variable "region" {
  default = "eu-gb"
}