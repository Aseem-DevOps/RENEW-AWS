resource "aws_launch_template" "this" {
  name_prefix   = var.name_prefix
  image_id      = var.ami
  instance_type = var.instance_type
  user_data     = var.user_data
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  vpc_security_group_ids = var.security_group_ids
  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = var.target_group_arns
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 60
  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
  tags = var.tags
}
