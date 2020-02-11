provider "aws" {
    region = "${var.region}"
    profile = "${var.aws_profile}"
  
}
resource "aws_s3_bucket" "site-logs" {
  bucket = "${var.website_name}-site-logs"
  acl = "log-delivery-write"
}

resource "aws_s3_bucket" "site-bucket" {
  bucket = "www.${var.website_name}"

  logging {
    target_bucket = "${aws_s3_bucket.site-logs.bucket}"
    target_prefix = "www.${var.website_name}/"
  }

  website {
    index_document = "index.html"
  }

}
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "cloudfront origin access identity"
}

data "aws_acm_certificate" "cert" {
  domain   = "${var.website_name}"
  statuses = ["ISSUED"]
}

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled      = true
  price_class  = "PriceClass_200"
  http_version = "http1.1"
  aliases = ["www.${var.website_name}", "${var.website_name}" ]

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.site-bucket.id}"
    domain_name = "www.${var.website_name}.s3.amazonaws.com"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    target_origin_id = "origin-bucket-${aws_s3_bucket.site-bucket.id}"

    min_ttl          = "0"
    default_ttl      = "300"                                           
    max_ttl          = "1200"                                           

    // HTTP to HTTPS redirection
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn      = "${data.aws_acm_certificate.cert.arn}"
   // acm_certificate_arn      = "${var.certificate_arn}"
    ssl_support_method       = "sni-only"
  }

}
