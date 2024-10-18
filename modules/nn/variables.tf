variable "rg-name" {
    type = string
}

variable "rg-location" {
    type = string
}

variable "lb-name" {
  type = string
  default = "lb-"
}

variable "frontend-ip-name" {
  type = string
  default = "frontend-ip-"
}

variable "public-ip-name" {
  type = string
  default = "public-ip-"
}

variable "subnet-id" {
  type = string
}