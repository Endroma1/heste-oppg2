variable "rg-name" {
    type = string
}

variable "rg-location" {
    type = string
}

variable "network-name" {
  type = string
  default = "network-id"
}

variable "network-sec-name" {
  type = string
  default = "network-id"
}

variable "subnet-name" {
  type = string
  default = "subnet-"
}