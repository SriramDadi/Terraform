resource "aws_instance" "EC2" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] //If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  instance_type          = "t3.micro"
  tags = {

    Name    = "Terraform-Demo"
    Purpose = "Terraform-Practice"

  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "tls-new"
  description = "Allow TLS inbound traffic and all outbound traffic"

  dynamic "ingress" { # terraform will give you a keyword with block name. you can iterate using ingress.
    for_each = var.ingress_ports
    content { # we have to keep the keyword content which you want to repeate
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" //all protocols
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "ec2_sg"
  }

}