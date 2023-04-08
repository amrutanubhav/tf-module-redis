resource "aws_security_group" "allow_redis" {
  name        = "roboshop-${var.ENV}-redis-sg"
  description = "allow ${var.REDIS_PORT} inbound traffic from intranet only"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    description      = "alow redis from local network"
    from_port        = var.REDIS_PORT
    to_port          = var.REDIS_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
    
  }

  ingress {
    description      = "alow redis from default vpc network"
    from_port        = var.REDIS_PORT
    to_port          = var.REDIS_PORT
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-redis-sg"
  }
}