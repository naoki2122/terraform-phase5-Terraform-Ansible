# Terraform Phase3: ALB + AutoScaling

## 概要
TerraformでALB + AutoScaling Group を構築し、冗長化されたWebサーバ構成を作成。

## 構成
- VPC / Public Subnet (2AZ)
- Application Load Balancer (HTTP)
- Auto Scaling Group (EC2 x2)
- user_dataでApache自動セットアップ
- ALBによる負荷分散
- AutoScaling Group による冗長化
- user_data による Apache 自動構築
- SSHを自IPのみに制限

## 実行
```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy

