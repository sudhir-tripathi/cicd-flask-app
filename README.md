# CI/CD Pipeline Architecture for Flask App Deployment on AWS

## Overview
This document outlines the continuous integration and deployment (CI/CD) pipeline used to deploy a Flask application on AWS using services like CodePipeline, CodeBuild, ECS Fargate, and ECR. The infrastructure is provisioned using AWS CloudFormation with separate stacks for network, ECR, ECS, and CI/CD resources.

---

## 🔁 Architecture Diagram


---

## 🔧 Components

### 🧾 Source Control
- **GitHub Repository**
  - Contains all application and infrastructure code:
    - `README.md`
    - `Dockerfile`
    - `requirements.txt`
    - `buildspec.yml`
    - `imagedefinitions.json`
    - `app/app.py`
    - CloudFormation templates under `cloudformation/`

### 🚀 CI/CD Infrastructure
- **CodePipeline**
  - Triggers on GitHub commits
  - Orchestrates the build and deployment process
- **CodeBuild**
  - Executes build commands from `buildspec.yml`
  - Builds Docker image
  - Pushes image to Amazon ECR

### 🐳 Container Image Management
- **Amazon ECR**
  - Stores Docker images
  - Integrated with ECS for seamless deployments

### 🛳️ Deployment Target
- **Amazon ECS Fargate**
  - Runs the Flask container as a service
  - Integrated with ALB for routing
- **Application Load Balancer (ALB)**
  - Routes incoming HTTP requests to ECS tasks

### 🌐 Network Infrastructure (Provisioned via CloudFormation)
- **Network Stack**
  - VPC
  - Public and private subnets
  - Internet Gateway (IGW)
  - NAT Gateway
- **ECR Stack**
  - Creates and manages ECR repository
- **ECS Stack**
  - Creates ECS Cluster, Task Definition, and Fargate Service
- **CI/CD Stack**
  - Sets up CodePipeline and CodeBuild resources

---

## 📦 Docker Image Build and Push (Manual Instructions)

You can manually build and push the Docker image to ECR using the following commands:

### 1. Authenticate Docker to ECR:
```bash
aws ecr get-login-password --region ap-south-1 \
  | docker login --username AWS \
  --password-stdin <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com
```

### 2. Tag the Docker image:
```bash
docker tag mane-dev-ecr-repo:latest \
  <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/mane-dev-ecr-repo:latest
```

### 3. Push the Docker image to ECR:
```bash
docker push <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/mane-dev-ecr-repo:latest
```

### 4. (Optional) List images in ECR to verify:
```bash
aws ecr list-images \
  --repository-name mane-dev-ecr-repo \
  --region ap-south-1
```

---

## 📎 Related CloudFormation Files (Click to View on GitHub)
- [GitHub Repository (Root)](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/README.md)
- [Flask App (app/app.py)](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/app/app.py)
- [CodePipeline Stack](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/cloudformation/cicd-stack.yml)
- [CodeBuild buildspec.yml](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/buildspec.yml)
- [Network Stack](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/cloudformation/network-stack.yml)
- [ECR Stack](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/cloudformation/ecr-stack.yml)
- [ECS Stack](https://github.com/sudhir-tripathi/cicd-flask-app/blob/main/cloudformation/ecs-stack.yml)

---

## ✅ Conclusion
This pipeline enables automated Docker image builds and deployments of your Flask app to AWS ECS Fargate. With modular infrastructure and GitHub integration, it is easy to maintain and scale.

