resource "aws_lb_target_group" "blue" {
  name     = var.blue_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
  tags = var.tags
}

resource "aws_lb_target_group" "green" {
  name     = var.green_name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
  tags = var.tags
}

resource "aws_lb_listener_rule" "weighted" {
  listener_arn = var.listener_arn
  action {
    type             = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.blue_weight
      }
      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.green_weight
      }
      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
