# Phase5 - Terraform × ALB × ASG × SSM（SSHレス運用）

## 概要
TerraformでAWS上にWeb基盤（ALB + ASG）を構築し、運用はSystems Manager（SSM）で行うポートフォリオです。  
SSH(22)を使わず、鍵レスでオペレーションできる構成を重視しています。

## ゴール
- Terraformでインフラをコード化
- Ansibleでミドルウェアインストール
- ALB + ASGで冗長化/スケールに対応
- EC2への管理アクセスはSSM（鍵レス）で実施
- 22ポートは開けない設計

## 構成図
![構成図](./https://github.com/naoki2122/terraform-phase5-Terraform-Ansible/blob/main/phase5_architecture.png)


## 構成
- VPC（Public Subnet x2）
- Internet Gateway
- ALB（HTTP 80）
- Target Group
- ASG（EC2 x2〜）
- Launch Template
- IAM Role/Instance Profile（AmazonSSMManagedInstanceCore）
- SSM（Run Command / Session Manager）
- （Ansible）SSM経由で構成反映（運用手段として位置づけ）

## セキュリティ設計
| 対象 | inbound | 備考 |
|---|---|---|
| ALB | 80/tcp from 0.0.0.0/0 | 公開入口 |
| EC2 | 80/tcp from ALB SG | ALB以外からのHTTPは遮断 |
| EC2 | 22/tcp **なし** | SSHを使わない |




