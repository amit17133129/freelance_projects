resource "aws_instance" "web" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}