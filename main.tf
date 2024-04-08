resource "aws_instance" "this" {
  ami                     = data.aws_ami.ami.id
  instance_type           = var.instance_type
  subnet_id               = var.subnet_ids
}