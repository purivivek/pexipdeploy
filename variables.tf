variable "project" {
  type = "string"
}
variable "credentials" {
type = "string"
}
variable "region" {
  type = "string"
}
variable "region_for_na" {
  type = "string"
}

variable "region_for_apac" {
  type = "string"
}

variable "region_for_eu" {
  type = "string"
}

variable "na_cidr" {
  type        = "string"
  description = "cidr for na subnet"
  default     = "10.128.0.0/26"
}

variable "eu_cidr" {
  type        = "string"
  description = "cidr for eu subnet"
  default     = "10.132.0.0/26"
}

variable "apac_cidr" {
  type        = "string"
  description = "cidr for apac subnet"
  default     = "10.146.0.0/26"
}

variable "env_prefix" {
  type = "string"
}

variable "pexipman_image_url" {
  type = "string"
}
variable "pexipnode_image_url"{
  type = "string"
}

variable "pexipman_machine_type" {
  default = "n1-standard-2"
  type = "string"
}

variable "pexipnode_machine_type" {
  default = "n1-standard-8"
  type = "string"
}

variable "uszones" {
  type = "list"
}
variable "euzones"{
  type = "list"
}
variable "apzones"{
  type = "list"
}
	
variable "gce_ssh_user" {}
variable "gce_ssh_pub_key_file" {}