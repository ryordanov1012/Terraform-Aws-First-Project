#Create Bucket
resource "aws_s3_bucket" "TestSubject" {
  bucket = "my-something-1045"
  #Bucket names can consist only of lowercase letters, numbers, dots (.), and hyphens (-).
  
}
# Set bucket versioning
resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.TestSubject.id
  versioning_configuration {
    status = "Enabled"
  }
}
# Set bucket to private
resource "aws_s3_bucket_ownership_controls" "TestSubject" {
  bucket = aws_s3_bucket.TestSubject.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# Create bucket acl
resource "aws_s3_bucket_acl" "TestSubject" {
  depends_on = [aws_s3_bucket_ownership_controls.TestSubject]
  bucket = aws_s3_bucket.TestSubject.id
  acl    = "private"
}
