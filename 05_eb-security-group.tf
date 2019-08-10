resource "aws_security_group" "instance-security-group" {
  name        = "${var.env}-${var.app-name}-instance-security-group"
  description = "${var.env}-${var.app-name}-instance-security-group"
  vpc_id      = "${var.vpc[var.env]}"

 ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description = "Ingress from 10.16.40.0"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description = "All outbound ipv4"
  }

  tags = {
    Name = "${var.env}-${var.app-name}-instance-security-group"
  }
}

resource "aws_security_group" "internal-elb-security-group" {
  name        = "${var.env}-${var.app-name}-internal-elb-security-group"
  description = "${var.env}-${var.app-name}-internal-elb-security-group"
  vpc_id      = "${var.vpc[var.env]}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description = "Ingress from 10.16.40.0"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description = "All outbound ipv4"
  }

  tags = {
    Name = "${var.env}-${var.app-name}-internal-elb-security-group"
  }
}