terraform {
  backend "s3" {
    bucket = "467.devops.candidate.exam"
    key    = "addala.paramasiva"
    region = "ap-south-1"
  }
}
resource "aws_subnet" "private_subnet_1a" {
  vpc_id     = data.aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private_subnet_apsouth_1a"
  }
}

resource "aws_route_table" "rt-1a" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-1a"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.rt-1a.id
}

resource "aws_lambda_function" "invoke_http" {

  filename      = "invokehttprequest.py"
  function_name = "invoke_http_request"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"

  runtime = "python3.8"
  environment {
    variables = {
      subnet_id = aws_subnet.private_subnet_1a.id
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_1a.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
    vpc_id = data.aws_vpc.vpc.id
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "lambda-sg"
  }
}
