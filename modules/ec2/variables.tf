variable "ec2_instances" {
  type = map(object({
    ami                           = string
    instance_type                 = string
    subnet_id                     = string
    associate_public_ip_address   = optional(bool)
  }))
}

variable "env_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}
