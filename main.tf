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
    Name = "example"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.rt-1a.id
}

resource "aws_lambda_function" "invoke_http" {

  filename      = "invokehttprequest.py"
  function_name = "invoke_http_request"
  role          = data.aws_iam_role.lambda.name
  handler       = "lambda_function.lambda_handler"

  runtime = "python3.8"
  environment {
    variables = {
      subnet_id = aws_subnet.private_subnet_1a.id
    }
  }

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_1a.id]
    security_group_ids = [aws_security_group.sg_for_lambda.id]
    vpc_id = data.aws_vpc.vpc.id
  }
}
