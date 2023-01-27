provider "aws" {
    region = "ap-south-1"
  
}


resource aws_instance instance_1 {

    ami = "ami-0d031797c8d15af5e"
    instance_type = "t2.micro"
    
    tags  = {
        Name = "terraform-1"
    }
    # security_groups = ["${aws_security_group.terraform_1_sg.id}"]
    vpc_security_group_ids = ["${aws_security_group.terraform_1_sg.id}","${aws_security_group.terraform_2_sg.id}"]
}

resource "aws_security_group" "terraform_1_sg" {
  name = "terraform_1_sg"
  description = "inbound traffic for http"
  ingress {
    from_port="${var.port}"
    to_port="${var.port}"
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
}

resource "aws_security_group" "terraform_2_sg" {
  name = "terraform_2_sg"
  description = "inbound traffic for http"
  ingress {
    from_port="8080"
    to_port="8080"
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
}


variable "port" {
    description = "port value used to listen the server"
    default = "80"
    type = string
  
}


output "instance_ip" {
  value="${aws_instance.instance_1.public_ip}"
}
