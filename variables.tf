
variable "aws_region" {
    description = "AWS region for all resources."

    type    = string
    default = "us-east-2"
}

variable "account_id" {
    type    = string
    default = "sdx86s5DSDd42as4"
}

variable "access_key" {
    type    = string
    default = "sdx86s5DSDd42as4"
}

variable "secret_key" {
    type    = string
    default = "sdx86s5DSDd42as4"
}

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

variable "clients_rds_ids" {
    type    = list(string)
    default = ["sdx86s5DSDd42as4"]
}
