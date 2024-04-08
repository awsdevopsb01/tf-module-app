resource "aws_instance" "this" {
  ami                     = data.aws_ami.ami.id
  instance_type           = var.instance_type
  subnet_ids              = var.subnet_ids
}