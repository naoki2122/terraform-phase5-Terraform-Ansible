# EC2用 IAM Role
resource "aws_iam_role" "ec2_ssm_role" {
  name = "tf-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# SSMポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile作成
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "tf-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
