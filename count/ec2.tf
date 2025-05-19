resource "aws_instance" "expense" {
  count                  = 3
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id] //If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  instance_type          = "t3.micro"

  tags = {
    
    Name = var.instances[count.index]

  }
}

resource "aws_security_group" "allow_tls" {
  name        = "count_SG"
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
tags ={
    Name = "Expense-Backend-Dev"
  }
}
 
  
