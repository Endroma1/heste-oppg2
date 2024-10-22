variable "index-document" {
  type = string
  default = "<h1>Terraform<h1>"
}

variable "rg-name" {
    type = string
}

variable "rg-location" {
    type = string
}

variable "storage-acc-name" {
  type = string
  default = "storageacc"
}

variable "container-name" {
  type = string
  default = "container"
}

variable "blob-name" {
  type = string
  default = "blob"
}

variable "index_document" {
  type = string
  default = "index.html"
}

variable "source_content" {
  type = string
  default = "<h1>Static website<h1>"
}