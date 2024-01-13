


resource "aws_key_pair" "key" {
  key_name   = "aws-public-key-${var.environment}"
  public_key = file("./ec2-key.pub")
}



resource "aws_instance" "ec2" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = module.vpc.subnet_id
  vpc_security_group_ids      = [module.vpc.security_group_id]
  associate_public_ip_address = true
  user_data                   = file("./docs/init.sh")

  tags = {
    Name = "ec2-${var.environment}-terraform"
  }

}