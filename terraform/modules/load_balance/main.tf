#Frontend Target Group
resource "aws_lb_target_group" "frontend_target_group" {
  name        = "fe-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }
}

#Backend Target Group
resource "aws_lb_target_group" "backend_target_group" {
  name        = "be-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/api/students"
    protocol            = "HTTP"
    port                = "8080"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }
}

# certificate
data "aws_route53_zone" "dns" {
  name     = "lptdevops.com"
}

resource "aws_route53_record" "app_alias" {
  zone_id = data.aws_route53_zone.dns.zone_id
  name    = "lux.lptdevops.com"
  type    = "A"

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_lb.load_balancer]

}

resource "aws_acm_certificate" "ssl-cert" {
  domain_name       = "lux.lptdevops.com"
  validation_method = "DNS"
  tags = {
    Name = "Webservers-ACM"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for val in aws_acm_certificate.ssl-cert.domain_validation_options : val.domain_name => {
      name   = val.resource_record_name
      record = val.resource_record_value
      type   = val.resource_record_type
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.dns.zone_id

  depends_on = [aws_acm_certificate.ssl-cert]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.ssl-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
  depends_on              = [aws_route53_record.cert_validation]
}


#Application Load Balancer
resource "aws_lb" "load_balancer" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.load_balance_security_group_ids
  subnets            = var.load_balance_subnet_ids
  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
  enable_cross_zone_load_balancing = true
  tags = {
    Name = "alb"
  }
}

#Load Balancer Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl-cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
}

# Custom rule for /api/*
resource "aws_lb_listener_rule" "backend_api_rule" {
  listener_arn = "${aws_lb_listener.listener.arn}"
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.backend_target_group.arn}"
  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}