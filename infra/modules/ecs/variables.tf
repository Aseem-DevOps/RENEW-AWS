variable "name" { type = string } # e.g. "model-api-ecs-cluster"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "family" { type = string } # e.g. "model-api-task"
variable "cpu" { type = string } # e.g. "512"
variable "memory" { type = string } # e.g. "1024"
variable "execution_role_arn" { type = string } # e.g. "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
variable "task_role_arn" { type = string } # e.g. "arn:aws:iam::123456789012:role/ecsTaskRole"
variable "container_definitions" { type = string } # e.g. jsonencode([{ name = "app", image = "repo/image:tag", cpu = 256, memory = 512, portMappings = [{ containerPort = 8080, hostPort = 8080 }] }])
variable "service_name" { type = string } # e.g. "model-api-service"
variable "desired_count" { type = number } # e.g. 2
variable "subnet_ids" { type = list(string) } # e.g. ["subnet-abc123", "subnet-def456"]
variable "security_group_ids" { type = list(string) } # e.g. ["sg-abc123"]
variable "target_group_arn" { type = string } # e.g. "arn:aws:elasticloadbalancing:region:acct:targetgroup/abc123"
variable "container_name" { type = string } # e.g. "app"
variable "container_port" { type = number } # e.g. 8080
