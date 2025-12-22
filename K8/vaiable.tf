variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}


variable "instance_type" {
  description = "The type of instance to use for the EC2 instance"
  type        = string
  default     = "t3.small"
}
variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string

}

variable "instance" {
  description = "using for each for lunching instace "
  type        = map(string)

}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}