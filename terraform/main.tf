resource "aws_s3_bucket" "test-npm-bucket" {
  bucket = "codeclub-npm"

  tags = {
    Name        = "codeclub-npm"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "test-npm-bucket" {
  bucket = aws_s3_bucket.test-npm-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "test-npm-bucket" {
  bucket = aws_s3_bucket.test-npm-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "test-npm-bucket" {
  bucket = aws_s3_bucket.test-npm-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "test-npm-bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.test-npm-bucket,
    aws_s3_bucket_public_access_block.test-npm-bucket,
  ]

  bucket = aws_s3_bucket.test-npm-bucket.id
  acl    = "public-read-write"
}

resource "aws_s3_bucket_policy" "test-npm-bucket" {
  bucket = aws_s3_bucket.test-npm-bucket.id
  policy = data.aws_iam_policy_document.test-npm-bucket.json
}

data "aws_iam_policy_document" "test-npm-bucket" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.test-npm-bucket.arn,
      "${aws_s3_bucket.test-npm-bucket.arn}/*",
    ]
  }
}