data "aws_ami" "hemant_ami" {
  most_recent = true
  owners = ["self"]
  filter {
    name   = "name"
    values = var.value
  }
}

resource "aws_instance" "hemant" {
  ami           = "${data.aws_ami.hemant_ami.id}"
  instance_type = var.machinetype
  key_name = "ret"

  tags = {
    Name = "HelloWorld"
  }
}
