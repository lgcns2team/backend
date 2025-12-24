#!/bin/bash
set -e

exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "======================================"
echo "Spring Boot EC2 Setup Started"
echo "Time: $(date)"
echo "======================================"

# 시스템 업데이트
echo "Updating system packages..."
apt-get update
apt-get upgrade -y

# Docker 설치
echo "Installing Docker..."
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# AWS CLI 설치
echo "Installing AWS CLI..."
apt-get install -y awscli unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --update
rm -rf aws awscliv2.zip

# Java 17 설치
echo "Installing Java 17..."
apt-get install -y openjdk-17-jdk

# PostgreSQL Client 설치 (디버깅용)
echo "Installing PostgreSQL client..."
apt-get install -y postgresql-client

# ECR 로그인
echo "Logging into ECR..."
aws ecr get-login-password --region ${aws_region} | \
  docker login --username AWS --password-stdin ${ecr_registry}

# Docker Compose 파일 생성
echo "Creating docker-compose.yml..."
cat > /home/ubuntu/docker-compose.yml <<'EOF'
version: '3.8'

services:
  springboot:
    image: ${ecr_registry}/springboot-backend:latest
    container_name: springboot
    restart: always
    ports:
      - "8080:8080"
    environment:
      - SERVER_PORT=8080
      - SPRING_DATASOURCE_URL=${database_url}
      - SPRING_DATASOURCE_USERNAME=${db_username}
      - SPRING_DATASOURCE_PASSWORD=${db_password}
      - SPRING_REDIS_HOST=${redis_host}
      - SPRING_REDIS_PORT=6379
      - FASTAPI_URL=http://${fastapi_host}:8000
      - AWS_REGION=${aws_region}
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/actuator/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
EOF

# Docker 실행
echo "Starting Spring Boot service..."
cd /home/ubuntu
docker-compose up -d

# CloudWatch Agent 설치
echo "Installing CloudWatch Agent..."
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb
rm amazon-cloudwatch-agent.deb

chown -R ubuntu:ubuntu /home/ubuntu

echo "======================================"
echo "Spring Boot EC2 Setup Completed!"
echo "Time: $(date)"
echo "======================================"