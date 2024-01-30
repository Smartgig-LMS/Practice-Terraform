resource "aws_iam_instance_profile" "resources-iam-profile" {
name = "ec2_profile_new"
role = aws_iam_role.resources-iam-role.name
}
resource "aws_iam_role" "resources-iam-role" {
name        = "prod-ssm-role"
description = "The role for the production resources EC2"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": {
"Effect": "Allow",
"Principal": {"Service": "ec2.amazonaws.com"},
"Action": "sts:AssumeRole"
}
}
EOF
tags = {
    Name        = "${var.app_name}-ec2-ssm"
    Environment = var.app_environment
  }
}
resource "aws_iam_role_policy_attachment" "resources-ssm-policy" {
role       = aws_iam_role.resources-iam-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "ec2" {
 ami                    = var.ec2-ami
 instance_type          = var.ec2-instancetype
 subnet_id              = var.private_subnet_1_id
 iam_instance_profile   = aws_iam_instance_profile.resources-iam-profile.name 
root_block_device {
delete_on_termination = true
volume_type           = "gp2"
volume_size           = var.ec2-volume-size
}
tags = {
    Name        = "${var.app_name}-ec2"
    Environment = var.app_environment
  }
}