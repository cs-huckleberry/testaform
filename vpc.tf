resource "aws_vpc" "main" {
  cidr_block       = "10.251.0.0/16"
  
  tags = {
    Name = "main"
    Contact = "Christopher Smith"
    Agency = "OCIO-DISC"
    Team = "ASIB-EAG"
    Env = "Test"
    Agreement_ID = "OIR9950"
  }
}
resource "aws_security_group" "allow_tls_to_lb" {
  name        = "allow_tls_to_lb"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 443
    to_port     = 443
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["199.134.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    # PLI is for (Optional) List of prefix list IDs (for allowing access to VPC endpoints)
    # prefix_list_ids = ["pl-12c4e678"]
  }
}

resource "aws_subnet" "private_sub_1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.251.0.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet_1"
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.251.1.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet_2"
  }
}

resource "aws_subnet" "public_sub_1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.251.10.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_subnet" "public_sub_2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.251.11.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Public_Subnet_2"
  }
}