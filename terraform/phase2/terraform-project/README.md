\# Terraform AWS EC2 Portfolio



\## 概要

Terraformを用いてAWS環境（VPC, Subnet, EC2, Security Group）を自動構築するポートフォリオです。
EC2起動時にApache/Nginxを自動インストールし、Webページを自動表示する構成。




\## 構成図

!\[architecture](architecture.png)



\## 使用技術

\- Terraform

\- AWS EC2

\- VPC / Subnet

\- Security Group



\## 作成できるもの

\- VPC

\- Public Subnet

\- Internet Gateway

\- Route Table

\- Security Group

\- EC2 Instance



\## 実行手順

```bash

terraform init

terraform apply

terraform destroy



