variable "rg-name" {
    type = string
}

variable "rg-location" {
    type = string
}

variable "mssql-server-name" {
  type = string
  default = "sqlserver-"
}

variable "mssql-db-name" {
  type = string
  default = "sqldb-"
}