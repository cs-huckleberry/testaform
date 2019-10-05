#launches ec2 instance with AWS Linux 2

data "aws_ami" "aws_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20190823.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

 owners = ["137112412989"]

 
}
resource "aws_instance" "web_srv_1" {
  ami           = data.aws_ami.aws_linux_2.id
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  tags = {
    Name = "main"
    Contact = "Christopher Smith"
    Agency = "OCIO-DISC"
    Team = "ASIB-EAG"
    Env = "Test"
    Agreement_ID = "OIR9950"
  } 
}
# test push