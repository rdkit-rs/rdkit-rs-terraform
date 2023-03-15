resource "aws_iam_role" "gha-rdkit-debian" {
  name = "gha-rdkit-debian"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:rdkit-rs/rdkit-debian:*"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  inline_policy {
    name = "s3things"
    policy = jsonencode({
      Version="2012-10-17",
      Statement=[
        {
          Sid="s3ops"
          Action = ["s3:Get*", "s3:Put*", "s3:List*"],
          Effect = "Allow",
          Resource = [aws_s3_bucket.rdkit-debian.arn, format("%s/*",aws_s3_bucket.rdkit-debian.arn)]
        }
      ]
    })
  }
}