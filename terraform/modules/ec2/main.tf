resource "aws_instance" "bastion" {
  ami           = "ami-01938df366ac2d954"  # Replace with your region's Ubuntu AMI
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = {
    Name = var.bastion_name
  }
}
