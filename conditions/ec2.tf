resource "aws_instance" "EC2" {
  ami                    = var.ami_id
  vpc_security_group_ids = [aws_security_group.allow_tls.id] //If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  instance_type          = var.instance_type == "prod" ? "t3.small" :"t3.micro"
  tags                   = var.tags
}

resource "aws_security_group" "allow_tls" {
  name        = "tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" //all protocols
    cidr_blocks = var.cidr_blocks

  }

  tags = var.sg_tags

}