# Resources Block
# Resources-1: Create VPC
resource "aws_vpc" "Infra-vpc" {
  cidr_block = "10.10.0.0/20"
  tags = {
    "Name" = "Infra-vpc"
  }
}

# Resources-2: Create Subnets-1
resource "aws_subnet" "Infra-vpc-public-subnet-1" {
  vpc_id = aws_vpc.Infra-vpc.id 
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true   
}

# Resources-3: Create Subnets-2
resource "aws_subnet" "Infra-vpc-public-subnet-2" {
  vpc_id = aws_vpc.Infra-vpc.id 
  cidr_block = "10.10.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true   
}

# Resources-4: Create Internet Gateway
resource "aws_internet_gateway" "Infra-vpc-igw" {
  vpc_id = aws_vpc.Infra-vpc.id
}

# Resources-5: Create Route Table
resource "aws_route_table" "Infra-vpc-public-route-table" {
  vpc_id = aws_vpc.Infra-vpc.id  
}

# Resource-6: Create Route in Route Table for Internet Access
resource "aws_route" "Infra-vpc-public-route" {
  route_table_id =  aws_route_table.Infra-vpc-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Infra-vpc-igw.id
}

# Resource-7: Associate the Route Table with the Subnet
resource "aws_route_table_association" "Infra-vpc-public-route-table-association" {
   route_table_id =  aws_route_table.Infra-vpc-public-route-table.id
   subnet_id = aws_subnet.Infra-vpc-public-subnet-1.id
}

# Resource-8: Create Security Group
resource "aws_security_group" "Infra-vpc-sg" {
  name = "Infra-vpc-default-sg"
  description = "Infra VPC default Security Group"
  vpc_id = aws_vpc.Infra-vpc.id

  ingress {
    description = "Allow Port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "Allow Port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


 ingress{
    description = "Allow Port 2346"
    from_port = 2346
    to_port = 2346
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
