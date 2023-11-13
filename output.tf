output "db_instance_address" {
    description = "The address of the RDS instance"
    value   = aws_db_instance.db_fiapfood.address
}

output "db_instance_endpoint" {
    description = "The connection endpoint"
    value   = aws_db_instance.db_fiapfood.endpoint
}

output "vpc_id" {
    description = "VPC"
    value   = aws_vpc.vpc_rds_fiapfood.id
}

output "internet_gateway_id" {
    description = "Internet Gateway"
    value   = aws_internet_gateway.igw_rds_fiapfood.id
}