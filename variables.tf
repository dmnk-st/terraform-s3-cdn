// AWS Region
variable "region" {
    default = "us-east-1"
}
// Replace with your profile name
variable "aws_profile" {
    default = "your-aws-profile-name"
}
// Replace with your domain name
variable "website_name" {
    default = "your-domain-name"
}
// Your index.html file. Keep the file in the root directory
variable "index_file" {
    default = "index.html"
}
// Your photo file. Keep the file in the root directory
variable "photo_file" {
    default = "pic.jpg"
}
