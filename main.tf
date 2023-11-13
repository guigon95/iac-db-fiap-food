resource "aws_db_instance" "db_fiapfood" {
    allocated_storage = 20
    storage_type    = "gp2"
    engine          = "mysql"
    engine_version  = "8.0"
    instance_class  = "db.t3.micro"
    db_name         = var.db_name
    username        = var.db_username
    password        = var.db_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.rds_security_group.id]
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    publicly_accessible = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name       = "db_subnet_group_main"
    subnet_ids = [aws_subnet.subnet_rds_fiapfood_main.id, aws_subnet.subnet_rds_fiapfood_main_az2.id]

    tags = {
        Name = "My DB subnet group RDS"
    }
}