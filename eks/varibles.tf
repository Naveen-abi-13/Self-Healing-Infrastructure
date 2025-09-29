variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "key_name" {
  description = "SSH key name"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI ID for EC2"
  default     = "ami-0dee22c13ea7a9a67"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "self-healing-eks"
}

variable "node_count" {
  description = "Number of worker nodes"
  default     = 2
}
