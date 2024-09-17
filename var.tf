# Input Variables
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type = string
}

variable "ec2_instance_type" {
  description = "Type of AWS Instance"
  type = string
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type = string
}

variable "volume" {
  description = "Root volume of the Instance"
  type = string  
}