output "primary_alb_dns" {
  value = aws_lb.primary_alb.dns_name
}

output "secondary_alb_dns" {
  value = aws_lb.secondary_alb.dns_name
}


