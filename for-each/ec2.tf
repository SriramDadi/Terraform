resource "aws_instance" "EC2" {
  for_each = var.instances  # terrafrom will give us a keyword called each
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] //If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  instance_type          = each.value
  tags = {

    Name    = each.key
    Purpose = "Terraform-Practice"

  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "tls-new2"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

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