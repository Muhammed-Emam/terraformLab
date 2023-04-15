
# Create the ALB resource
resource "aws_lb" "nginx" {
  name = "globo"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  security_groups    = [aws_security_group.lb_sg.id]

  enable_deletion_protection = false


  tags = local.common_tags

}


resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    target_group_arn = aws_lb_target_group.nginx.arn
    type             = "forward"
  }
    tags = local.common_tags

}


# Create the target group
resource "aws_lb_target_group" "nginx" {
  name_prefix      = "nginx"
  port             = "80"
  protocol         = "HTTP"
  vpc_id           = aws_vpc.vpc.id

}

resource "aws_lb_target_group_attachment" "nginx1" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx1.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "nginx2" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx2.id
  port             = 80
}

