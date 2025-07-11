# main.tf - Broken Model API Infrastructure

provider "aws" {
  region = "us-east-1"
}

# VPC Configuration
resource "aws_vpc" "model_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "model-api-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.model_vpc.id
  cidr_block = "10.0.1.0/24"
  
  tags = {
    Name = "model-api-subnet"
  }
}


resource "aws_security_group" "model_sg" {
  name        = "model-api-sg"
  description = "Security group for model API"
  vpc_id      = aws_vpc.model_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_s3_bucket" "model_bucket" {
  bucket = "my-ml-models-bucket"
  acl    = "public-read-write"
  
  tags = {
    Environment = "production"
  }
}


resource "aws_iam_role" "model_api_role" {
  name = "model-api-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "model_api_policy" {
  name = "model-api-policy"
  role = aws_iam_role.model_api_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "*"
        Action = ["*"]
        Resource = "*"
      }
    ]
  })
}


resource "aws_instance" "model_api_server" {
  ami           = "ami-12345678" 
  instance_type = "t2.micro"      
  subnet_id     = aws_subnet.public_subnet.id
  
  vpc_security_group_ids = [aws_security_group.model_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.model_profile.name
  

  user_data = <<-EOF
    #!/bin/bash
    export API_KEY="sk-1234567890abcdef"
    export DB_PASSWORD="admin123"
    export MODEL_ENDPOINT="http://localhost:8080"
    
    # Install dependencies
    apt-get update
    apt-get install -y python3 python3-pip
    
    # Start API server
    python3 /app/server.py
  EOF

  tags = {
    Name = "model-api-server"
  }
}

# Missing IAM Instance Profile
resource "aws_iam_instance_profile" "model_profile" {
  name = "model-api-profile"
  role = aws_iam_role.model_api_role.name
}


resource "aws_db_instance" "model_db" {
  identifier     = "model-api-db"
  engine         = "postgres"
  engine_version = "12.5"
  instance_class = "db.t2.micro"
  
  allocated_storage = 20
  storage_type      = "gp2"
  
  db_name  = "modeldb"
  username = "admin"
  password = "password123"  
  
  vpc_security_group_ids = [aws_security_group.model_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.model_db_subnet.name
  
  publicly_accessible = true
  skip_final_snapshot = true
  

  backup_retention_period = 0
}


resource "aws_db_subnet_group" "model_db_subnet" {
  name       = "model-db-subnet-group"
  subnet_ids = [aws_subnet.public_subnet.id]  
  
  tags = {
    Name = "Model DB subnet group"
  }
}


resource "aws_lb" "model_alb" {
  name               = "model-api-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.model_sg.id]
  subnets            = [aws_subnet.public_subnet.id] 

  enable_deletion_protection = false
  enable_http2              = true
}


resource "aws_lb_target_group" "model_tg" {
  name     = "model-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.model_vpc.id
}

resource "aws_lb_listener" "model_listener" {
  load_balancer_arn = aws_lb.model_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.model_tg.arn
  }
}


resource "aws_lambda_function" "model_inference" {
  filename      = "lambda_function.zip"
  function_name = "model-inference"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python2.7"  
  
  environment {
    variables = {
      MODEL_BUCKET = aws_s3_bucket.model_bucket.bucket
      API_KEY      = "hardcoded-api-key"
    }
  }
}


resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_api_gateway_rest_api" "model_api" {
  name        = "model-api"
  description = "Model serving API"
}


resource "aws_ecr_repository" "model_repo" {
  name = "model-api-repo"
}


resource "aws_ecs_cluster" "model_cluster" {
  name = "model-api-cluster"
}




output "db_connection_string" {
  value = "postgresql://${aws_db_instance.model_db.username}:${aws_db_instance.model_db.password}@${aws_db_instance.model_db.endpoint}/${aws_db_instance.model_db.db_name}"
}

output "api_key" {
  value = "sk-1234567890abcdef"
}
