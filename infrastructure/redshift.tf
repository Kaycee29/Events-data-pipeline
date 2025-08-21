# VPC
resource "aws_vpc" "firstvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "firstvpc"
  }
}

# Subnets
resource "aws_subnet" "firstsubnet001" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "firstsubnet001"
  }
}

resource "aws_subnet" "secondsubnet002" {
  vpc_id            = aws_vpc.firstvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "secondsubnet002"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "first_igw" {
  vpc_id = aws_vpc.firstvpc.id

  tags = {
    Name = "firstvpc_igw"
  }
}

# Route Table
resource "aws_route_table" "publicroutetable" {
  vpc_id = aws_vpc.firstvpc.id

  tags = {
    Name = "publicroutetable"
  }
}

resource "aws_route" "firstinternetroute" {
  route_table_id         = aws_route_table.publicroutetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.first_igw.id
}

resource "aws_route_table_association" "firstsubnet001_association" {
  subnet_id      = aws_subnet.firstsubnet001.id
  route_table_id = aws_route_table.publicroutetable.id
}

resource "aws_route_table_association" "secondsubnet002_association" {
  subnet_id      = aws_subnet.secondsubnet002.id
  route_table_id = aws_route_table.publicroutetable.id
}

# Redshift Subnet Group
resource "aws_redshift_subnet_group" "redshift_subnets" {
  name       = "redshift-subnet-group"
  subnet_ids = [aws_subnet.firstsubnet001.id, aws_subnet.secondsubnet002.id]

  tags = {
    Name = "redshift-subnets-group"
  }
}

# SSM Parameters
resource "aws_ssm_parameter" "redshift_username" {
  name  = "redshift_username"
  type  = "String"
  value = "kaycee3000"
}

resource "random_password" "password" {
  length  = 8
  special = false
}
  
resource "aws_ssm_parameter" "redshift_password" {
  name  = "redshift_password"
  type  = "String"
  value = random_password.password.result
}

# Security group for Redshift
resource "aws_security_group" "redshift_sg" {
  name        = "redshift_sg"
  description = "Allow Redshift inbound traffic and all outbound"
  vpc_id      = aws_vpc.firstvpc.id

  tags = {
    Name = "redshift_sg"
  }
}

# Ingress / Egress rules
resource "aws_vpc_security_group_ingress_rule" "redshift_ingress_rule" {
  security_group_id = aws_security_group.redshift_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5439
  ip_protocol       = "tcp"
  to_port           = 5439
}

resource "aws_vpc_security_group_egress_rule" "redshift_egress_rule" {
  security_group_id = aws_security_group.redshift_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Redshift Cluster
resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier        = "first-redshift-cluster"
  database_name             = "event_transactional_db"
  master_username           = aws_ssm_parameter.redshift_username.value
  master_password           = aws_ssm_parameter.redshift_password.value
  node_type                 = "ra3.large"
  cluster_type              = "single-node"
  publicly_accessible       = true
  vpc_security_group_ids    = [aws_security_group.redshift_sg.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnets.name
 

  tags = {
    Name = "Event transactions"
  }
}
