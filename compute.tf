#launches ec2 instance with latest rev of AWS Linux 2

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
  ami           = "data.aws_ami.aws_linux_2.id"
  instance_type = "t2.micro"
  #user_data = file("user_data.sh")
  security_groups = aws_security_group.instance.id
  tags = {
    Name = "main"
    Contact = "Christopher Smith"
    Agency = "FBI"
    Team = "Red"
    Env = "Test"
    Agreement_ID = "ABC123"
  } 
}
# test push

data "aws_availability_zones" "available" {
  state = "available"
}

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    default = 8080
}
resource "aws_autoscaling_group" "web_app_1" {
    launch_configuration  = aws_launch_configuration.example.id
    availability_zones = data.aws_availability_zones.all.names
    load_balancers      = aws_elb.example.name
    health_check_type   = "ELB"

    min_size = 2
    max_size = 10

    tag {
        key                     = "Name"
        value                   = "terraform-asg-example"
        propagate_at_launch     = true
    }
}