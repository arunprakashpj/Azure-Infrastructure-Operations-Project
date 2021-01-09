variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "udacity-azure-webserver"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "North Europe"
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)
  default = {
    Name = "udacity-azure-webserver"
  }
}

variable "username" {
  description = "Enter username to associate with the machine"
}

variable "password" {
  description = "Enter password to use to access the machine"
}

variable "packer_resource_group" {
  description = "Resource group of the Packer image"
}

variable "packer_image_name" {
  description = "Image name of the Packer image"
}