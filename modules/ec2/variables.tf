variable "ec2_instances" {
    type = map(map(string))
}

variable "env_prefix" {
    type = string
}

variable "vpc_id" {
    type = string
}
