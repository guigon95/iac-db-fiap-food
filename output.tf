output "db_instance_address" {
    description = "The address of the RDS instance"
    value   = aws_db_instance.default.address
}

output "db_instance_endpoint" {
    description = "The connection endpoint"
    value   = aws_db_instance.default.endpoint
}
