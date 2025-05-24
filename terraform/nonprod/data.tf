data "aws_availability_zones" "available" {}

output "available_azs" {
  value = data.aws_availability_zones.available.names
}
