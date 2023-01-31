# Retrieve AWS Account ID
data "aws_caller_identity" "current" {}

# Create a VPC
resource "aws_vpc" "the_vpc" {
  cidr_block = var.vpc_supernet

  tags = {
    name = "${var.projectname}_VPC"
  }
}

# Create subnets
resource "aws_subnet" "the_dmz1" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = var.dmz1_subnet
  availability_zone = var.vpc_availability_zone

  tags = {
    name = "${var.projectname}_DMZ1"
  }
}

resource "aws_subnet" "the_dmz2" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = var.dmz2_subnet
  availability_zone = var.vpc_availability_zone

  tags = {
    name = "${var.projectname}_DMZ2"
  }
}

resource "aws_subnet" "the_cloudngfw_subnet" {
  vpc_id            = aws_vpc.the_vpc.id
  cidr_block        = var.cloudngfw_subnet
  availability_zone = var.vpc_availability_zone

  tags = {
    name = "${var.projectname}_CloudNGFW"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.the_vpc.id

  tags = {
    name = "${var.projectname}_IGW"
  }
}

# Create route tables
resource "aws_route_table" "dmz1_rt" {
  vpc_id = aws_vpc.the_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "${var.projectname}_DMZ1_RouteTable"
  }
}

resource "aws_route_table" "dmz2_rt" {
  vpc_id = aws_vpc.the_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "${var.projectname}_DMZ2_RouteTable"
  }
}

resource "aws_route_table" "cloudngfw_rt" {
  vpc_id = aws_vpc.the_vpc.id

  tags = {
    name = "${var.projectname}_CloudNGFW_RouteTable"
  }
}

# Assign the route tables to subnets
resource "aws_route_table_association" "rt_association_dmz1" {
  subnet_id      = aws_subnet.the_dmz1.id
  route_table_id = aws_route_table.dmz1_rt.id
}

resource "aws_route_table_association" "rt_association_dmz2" {
  subnet_id      = aws_subnet.the_dmz2.id
  route_table_id = aws_route_table.dmz2_rt.id
}

resource "aws_route_table_association" "rt_association_cloudngfw" {
  subnet_id      = aws_subnet.the_cloudngfw_subnet.id
  route_table_id = aws_route_table.cloudngfw_rt.id
}

# Retrieve AMI ID for latest Ubuntu 20.04
data "aws_ami" "ubuntu_2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Generate a Key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = "key_pair"
  public_key = tls_private_key.private_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "ssh_private_key.pem"
  content  = tls_private_key.private_key.private_key_pem
}

# Create hosts
resource "aws_instance" "the_host1" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = var.host_instance_type
  subnet_id                   = aws_subnet.the_dmz1.id
  private_ip                  = var.host1_ip
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.dmz_sg.id]
  key_name                    = aws_key_pair.key_pair.key_name

  tags = {
    name = "${var.projectname}_Host1"
  }
}

resource "aws_instance" "the_host2" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = var.host_instance_type
  subnet_id                   = aws_subnet.the_dmz2.id
  private_ip                  = var.host2_ip
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.dmz_sg.id]
  key_name                    = aws_key_pair.key_pair.key_name

  tags = {
    name = "${var.projectname}_Host2"
  }
}

# Create Elastic IPs for the hosts
resource "aws_eip" "host1_eip" {
  vpc = true
  tags = {
    name = "${var.projectname}_Host1_EIP"
  }
}

resource "aws_eip" "host2_eip" {
  vpc = true
  tags = {
    name = "${var.projectname}_Host1_EIP"
  }
}

# Associate Elastic IPs to hosts
resource "aws_eip_association" "host1_eip_association" {
  instance_id   = aws_instance.the_host1.id
  allocation_id = aws_eip.host1_eip.id
}

resource "aws_eip_association" "host2_eip_association" {
  instance_id   = aws_instance.the_host2.id
  allocation_id = aws_eip.host2_eip.id
}

# Create security group for the hosts
resource "aws_security_group" "dmz_sg" {
  name   = "${var.projectname}_dmz_sg"
  vpc_id = aws_vpc.the_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming SSH connections"
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming ping"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }
}

# Create CloudWatch Log Group for Cloud NGFW logging
resource "aws_cloudwatch_log_group" "cloudngfw_log_group" {
  # The name must be PaloAltoCloudNGFW to ensure Cloud NGFW has permissions to write logs to CloudWatch
  name = "PaloAltoCloudNGFW"

  tags = {
    name = "${var.projectname}_Log_Group"
  }
}

# Create IAM role for Cloud NGFW's operations
resource "aws_iam_role" "ngfw_role" {
  name = "CloudNGFWOpsRole"

  inline_policy {
    name = "apigateway_policy"

    # A policy that allows access to AWS API...
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "execute-api:Invoke",
            "execute-api:ManageConnections"
          ],
          "Resource" : "arn:aws:execute-api:*:*:*"
        }
      ]
    })
  }

  # ...and the policy above can be assumed, via this role, only by...
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          # ...AWS API Gateway itself...
          "Service" : "apigateway.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          # ...and the AWS user account(s) specified here:
          "AWS" : [
            # For simplicity, use the account currently executing Terraform
            data.aws_caller_identity.current.arn
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    CloudNGFWRulestackAdmin = "Yes"
    CloudNGFWFirewallAdmin  = "Yes"
  }
}
