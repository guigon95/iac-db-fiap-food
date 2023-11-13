# VPC configuration
resource "aws_vpc" "vpc_rds_fiapfood" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
}

# Subnet configuration
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

# Internet Gateway configuration
resource "aws_internet_gateway" "igw_rds_fiapfood" {
    vpc_id = aws_vpc.vpc_rds_fiapfood.id
    tags = {
        Name = "igw_rds_fiapfood"
    }
}

# Route Table configuration
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


# Security Group configuration for RDS
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
































#resource "aws_vpc" "vpc2" {
#    cidr_block = "10.1.0.0/16"
#}





#resource "aws_subnet" "subnet2" {
#    vpc_id = aws_vpc.vpc2.id
#    cidr_block = "10.1.0.0/24"
#}



#resource "aws_route_table" "route_table2" {
#    vpc_id = aws_vpc.vpc2.id
#
#    route {
#        cidr_block = "0.0.0.0/0"
#        gateway_id = aws_internet_gateway.igw.id
#    }
#}
#
# Security Group configuration for ECS
#resource "aws_security_group" "ecs_security_group" {
#    vpc_id = aws_vpc.vpc1.id
#    id = "sg-ecs-fiapfood"
#    ingress {
#        from_port = 80
#        to_port = 80
#        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
#    }
#}








## RDS Instance configuration
#resource "aws_db_instance" "db_instance" {
#    allocated_storage = 20
#    engine = "mysql"
#    engine_version = "5.7"
#    instance_class = "db.t2.micro"
#    name = "mydbinstance"
#    username = "admin"
#    password = "password"
#    vpc_security_group_ids = [aws_security_group.rds_security_group.id]
#    subnet_group_name = aws_subnet.subnet2.id
#}
#
## ECS Instance configuration
#resource "aws_ecs_cluster" "ecs_cluster" {
#    name = "myecscluster"
#}
#
#resource "aws_ecs_task_definition" "ecs_task_definition" {
#    family = "myecstask"
#    container_definitions = <<DEFINITION
#[
#  {
#    "name": "mycontainer",
#    "image": "nginx",
#    "portMappings": [
#      {
#        "containerPort": 80,
#        "hostPort": 80,
#        "protocol": "tcp"
#      }
#    ]
#  }
#]
#DEFINITION
#}

#resource "aws_ecs_service" "ecs_service" {
#    name = "myecsservice"
#    cluster = aws_ecs_cluster.ecs_cluster.id
#    task_definition = aws_ecs_task_definition.ecs_task_definition.arn
#    desired_count = 1
#
#    network_configuration {
#        subnets = [aws_subnet.subnet1.id]
#        security_groups = [aws_security_group.ecs_security_group.id]
#    }
#}
