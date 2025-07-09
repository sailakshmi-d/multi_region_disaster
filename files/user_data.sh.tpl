#!/bin/bash
yum update -y
yum install -y httpd aws-cli
systemctl start httpd
systemctl enable httpd

aws s3 cp s3://${s3_bucket}/index.html /var/www/html/index.html
aws s3 cp s3://${s3_bucket}/image.jpg /var/www/html/image.jpg

