variable "IBMcloud_api_key"{
  description = "IBM Cloud API Key"
  type = string
  sensitive = true
}


variable "region" {
  default = "eu-gb"
}