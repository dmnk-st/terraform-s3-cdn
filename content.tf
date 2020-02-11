
//Website Content
resource "aws_s3_bucket_object" "content" {
  //depends_on = ["aws_s3_bucket.website-bucket"]
 // bucket = "www.${var.website_name}"
  bucket = aws_s3_bucket.site-bucket.bucket
  //key    = "index.html"
  //source = "index.html"
  key    = "${var.content_file}"
  source = "${var.content_file}"

  //check file changes and compare
  etag = "${filemd5("${var.content_file}")}"
  content_type = "text/html"
}
//PHOTO 
resource "aws_s3_bucket_object" "photo" {
 // depends_on = ["aws_s3_bucket.website-bucket"]
 // bucket = "www.${var.website_name}"
  bucket = aws_s3_bucket.site-bucket.bucket
  //key    = "pic.jpg"
  //source = "pic.jpg"
  key    = "${var.photo_file}"
  source = "${var.photo_file}"
  
  //check file changes and compare
  etag = "${filemd5("${var.photo_file}")}"
}

