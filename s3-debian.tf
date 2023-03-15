resource "aws_s3_bucket" "rdkit-debian" {
  bucket = "rdkit-rs-debian"
}

resource "aws_s3_bucket_public_access_block" "rdkit-debian" {
  bucket = aws_s3_bucket.rdkit-debian.id

  restrict_public_buckets = false
}
