terraform {
    required_providers{
        ibm = {
            source = "IBM-Cloud/ibm"
            version= ">= 1.60.0"
        }
    }
}

provider "ibm"{
    region = "au-syd"
}