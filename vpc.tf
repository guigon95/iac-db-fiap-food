resource "aws_vpc" "vpc_rds_fiapfood" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_rds_fiapfood_main" {
    vpc_id = aws_vpc.vpc_rds_fiapfood.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
}

resource "aws_subnet" "subnet_rds_fiapfood_main_az2" {
    vpc_id     = aws_vpc.vpc_rds_fiapfood.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-2b"

}

resource "aws_internet_gateway" "igw_rds_fiapfood" {
    vpc_id = aws_vpc.vpc_rds_fiapfood.id
    tags = {
        Name = "igw_rds_fiapfood"
    }
}

resource "aws_route_table" "route_table_rds_fiapfood" {
    vpc_id = aws_vpc.vpc_rds_fiapfood.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_rds_fiapfood.id
    }
}

resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.subnet_rds_fiapfood_main.id
    route_table_id = aws_route_table.route_table_rds_fiapfood.id
}

resource "aws_route_table_association" "subnet_rds_fiapfood_main_az2" {
    subnet_id      = aws_subnet.subnet_rds_fiapfood_main_az2.id
    route_table_id = aws_route_table.route_table_rds_fiapfood.id
}


resource "aws_security_group" "rds_security_group" {
    name        = "allow_rds_traffic"
    vpc_id = aws_vpc.vpc_rds_fiapfood.id
    description = "Security Group configuration for RDS"
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = [var.clients_rds_ids]
    }
#    ingress {
#        description = "RDS from ECS"
#        from_port = 3306
#        to_port = 3306
#        protocol = "tcp"
#        security_groups = ["sg-ecs-fiapfood"]
#    }
}