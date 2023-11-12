
variable "aws_region" {
    description = "AWS region for all resources."

    type    = string
    default = "us-east-2"
}

#variable "account_id" {
#    type    = string
#}
#
#variable "access_key" {
#    type    = string
#}
#
#variable "secret_key" {
#    type    = string
#}

variable "db_name" {
    description = "The name of the database to create when the DB instance is created"
    type    = string
    default = "mydb"
}

variable "db_username" {
    description = "Username for the master DB user"
    type    = string
    default = "foo"
}

variable "db_password" {
    description = "Password for the master DB user"
    type    = string
    default = "foobarbaz"
}

