resource "aws_key_pair" "key" {
  count = var.environment == "dev" ? 2 : 1

  key_name   = "aws-public-key-${var.environment}-${count.index}"
  public_key = file("./ec2-key.pub")
}

resource "aws_iam_user" "the-accounts" {
  for_each = toset(["Todd", "James", "Alice", "Dottie"])
  name     = each.key
}

output "users_account" {
  value = [for a in aws_iam_user.the-accounts : a.name]
}


resource "aws_instance" "ec2" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key[0].key_name
  subnet_id                   = module.vpc.subnet_id
  vpc_security_group_ids      = [module.vpc.security_group_id]
  associate_public_ip_address = true
  user_data                   = file("./docs/init.sh")

  tags = {
    Name = "ec2-${var.environment}-terraform"
  }

}