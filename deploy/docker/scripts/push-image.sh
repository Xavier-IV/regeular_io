#!/bin/bash

# Get user input for region, AWS account ID, version, and environment
read -p "Enter version (or press Enter to use 'latest'): " version
read -p "Choose environment (production/staging): " environment

# Set a default version to "latest" if user input is empty
version="${version:-latest}"

# Fetch AWS region from AWS CLI
region=$(aws configure get region)

# Fetch AWS account ID from AWS CLI
aws_account_id=$(aws sts get-caller-identity --query "Account" --output text)

# Ensure that region and account ID are not empty
if [ -z "$region" ] || [ -z "$aws_account_id" ]; then
  echo "Failed to fetch AWS region or account ID. Please configure AWS CLI or provide the necessary information."
  exit 1
fi


# Get Docker login token and log in to ECR
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$aws_account_id.dkr.ecr.$region.amazonaws.com"

# Build Docker image with environment-specific tag
docker build --platform linux/amd64 -t "regeular-$environment" . -f ./deploy/docker/environment/distribution/Dockerfile

# List Docker images
docker images

# Automatically select the latest image ID
image_id=$(docker images -q | head -n 1)

# Tag Docker image with environment and version
docker tag "$image_id" "$aws_account_id.dkr.ecr.$region.amazonaws.com/regeular-$environment:$version"

# Push Docker image
docker push "$aws_account_id.dkr.ecr.$region.amazonaws.com/regeular-$environment:latest"
