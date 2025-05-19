variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "This is RHEL9 AMI ID"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "tags" {
  type = map(any)
  default = {
    Project     = "Expense"
    Component   = "Backend"
    Environment = "Dev"
    Name        = "Expense-Backend-Dev"
  }
}

variable "Environment" {
  default = "Dev"
  
}

variable "from_port" {
  type    = number
  default = 22
}
variable "to_port" {
  type    = number
  default = 22
}

variable "cidr_blocks" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "sg_tags" {
  type = map
  default = {
    Name = "Expense-Backend-Dev"
  }
}