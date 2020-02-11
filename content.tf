
//Website content file 
resource "aws_s3_bucket_object" "content" {
  bucket = aws_s3_bucket.site-bucket.bucket
  key    = "${var.index_file}"
  source = "${var.index_file}"

  //check file for changes
  etag = "${filemd5("${var.index_file}")}"
  content_type = "text/html"
}
//Website photo file
resource "aws_s3_bucket_object" "photo" {
  bucket = aws_s3_bucket.site-bucket.bucket
  key    = "${var.photo_file}"
  source = "${var.photo_file}"

  //check file for changes
  etag = "${filemd5("${var.photo_file}")}"
}

