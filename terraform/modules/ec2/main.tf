resource "aws_instance" "bastion" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your region's Ubuntu AMI
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = {
    Name = var.bastion_name
  }
}
