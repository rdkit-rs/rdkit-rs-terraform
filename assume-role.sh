# you should source this with `. assume-role.sh` so it evaluates in the context of the calling shell
# from stack overflow, naturally https://stackoverflow.com/posts/67636523/revisions

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
  $(aws sts assume-role \
  --role-arn arn:aws:iam::989722935798:role/OrganizationAccountAccessRole \
  --role-session-name MySessionName \
  --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
  --output text)
)