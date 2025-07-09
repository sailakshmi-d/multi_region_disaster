variable "primary_region" {
  default = "us-east-1"
}

variable "secondary_region" {
  default = "us-west-1"
}
variable "vpc_cidr" {
  default = "192.168.4.0/24"
}

variable "public_subnet_cidr_1" {
  default = "192.168.4.0/26"
}

variable "public_subnet_cidr_2" {
  default = "192.168.4.64/26"
}

variable "private_subnet_cidr_1" {
  default = "192.168.4.128/26"
}

variable "private_subnet_cidr_2" {
  default = "192.168.4.192/26"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}
#cidr of secondary region 
variable "vpc_cidr_secondary" {
  default = "192.168.5.0/24"
}

variable "public_subnet_cidr_1_secondary" {
  default = "192.168.5.0/26"
}

variable "public_subnet_cidr_2_secondary" {
  default = "192.168.5.64/26"
}

variable "private_subnet_cidr_1_secondary" {
  default = "192.168.5.128/26"
}

variable "private_subnet_cidr_2_secondary" {
  default = "192.168.5.192/26"
}

variable "availability_zone_1_secondary" {
  default = "us-west-1a"
}

variable "availability_zone_2_secondary" {
  default = "us-west-1c"
}
#RDS
#variable "db_username" {
 #default = "admin"
#}

#variable "db_password" {
  #default = "MySecurePassword123"
#}


