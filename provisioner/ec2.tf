resource "aws_instance" "EC2" {
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id] //If you are creating Instances in a VPC, use vpc_security_group_ids instead.
  instance_type          = "t3.micro"
  tags = {

    Name    = "Terraform-Demo"
    Purpose = "Terraform-Practice"

  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory"  //self refers to the resource "aws_instance" "EC2
  }

connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
    ]
  }

  
}

resource "aws_security_group" "ec2_sg" {
  name        = "tls-new1"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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