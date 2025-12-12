resource "aws_instance" "main" {
    for_each = var.ec2_instances
    ami = each.value.ami
    instance_type = each.value.instance_type

    subnet_id = each.value.subnet_id
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = {
        Name = "${var.env_prefix}-${each.key}"
        ManagedBy = "Terraform"
    }
}
