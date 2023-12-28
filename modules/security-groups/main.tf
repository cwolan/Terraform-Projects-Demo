# create security group for application load balancer
resource "aws_security_group" "alb_sg" {
    name         = "alb sg"
    description  = "http/https access on port 80/443"
    vpc_id       = var.vpc_id


    ingress  {
        description       = "http access"
        from_port         = 80
        to_port           = 80
        protocol          = "tcp"
        cidr_blocks        = ["0.0.0.0/0"]
    }

    ingress  {
        description       = "https access"
        from_port         = 443
        to_port           = 443
        protocol          = "tcp"
        cidr_blocks        = ["0.0.0.0/0"]
    }

    egress  {
        from_port         = 0
        to_port           = 0
        protocol          = -1
        cidr_blocks        = ["0.0.0.0/0"]
    }

    tags       = {
        Name   = "alb sg"
    }
  
}

# create security group for container
resource "aws_security_group" "ecs_sg" {
    name         = "ecs sg"
    description  = "http/https access on port 80/443 via alb sg"
    vpc_id       = var.vpc_id


    ingress  {
        description       = "http access"
        from_port         = 80
        to_port           = 80
        protocol          = "tcp"
        security_groups   = [aws_security_group.alb_sg.id]
    }

    ingress  {
        description       = "https access"
        from_port         = 443
        to_port           = 443
        protocol          = "tcp"
        security_groups   = [aws_security_group.alb_sg.id]
    }

    egress  {
        from_port         = 0
        to_port           = 0
        protocol          = -1
        cidr_blocks        = ["0.0.0.0/0"]
    }

    tags       = {
        Name   = "ecs sg"
    }
  
}
