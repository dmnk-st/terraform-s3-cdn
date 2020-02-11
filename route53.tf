data "aws_route53_zone" "selected" {
  name         = "${var.website_name}"
  private_zone = false
}
resource "aws_route53_record" "checkout-site" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "www.${var.website_name}"
  type = "A"
  alias {
    name = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    zone_id  = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "checkout-site-non-www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "${var.website_name}"
  type = "A"
  alias {
    name = "${aws_cloudfront_distribution.website_cdn.domain_name}"
    zone_id  = "${aws_cloudfront_distribution.website_cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}
