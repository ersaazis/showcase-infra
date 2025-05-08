resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Allow MySQL access from VPC"
  vpc_id      = data.terraform_remote_state.data_production_vpc.outputs.vpc_id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,data.terraform_remote_state.production_vpc.outputs.vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "rds-mysql-sg"
    Environment = "data-production"
  }
}

resource "aws_db_subnet_group" "mysql" {
  name       = "mysql-subnet-group"
  subnet_ids = data.terraform_remote_state.data_production_vpc.outputs.private_subnets

  tags = {
    Name = "mysql-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier              = var.db_identifier
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  port                    = 3306
  multi_az                = false
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.mysql.name
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7

  tags = {
    Name        = var.db_identifier
    Environment = "data-production"
  }
}
