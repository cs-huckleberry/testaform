provider "aws" {
    region = "us-west-2"
}
resource "aws_instance" "ec2-test-terraform" {
    ami             = "ami-79873901"
    instance_type   = "t2.micro"
    tags {
    Name = "terraform-example"
    }
}