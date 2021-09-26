resource "aws_instance" "phpapp" {
  ami           = lookup(var.AmiLinux, var.region)
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = aws_subnet.PublicAZA.id
  vpc_security_group_ids = [aws_security_group.WebApp.id]
  #key_name = var.key_name
  key_name = "Testkey"
  tags = {
        Name = "ec2_devops"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  yum install -y tomcat
  service tomcat start
  chkconfig tomcat on
  echo "<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Hello World - JSP tutorial</title>
</head>
<body>
    <%= "Hello World!" %>
</body>
</html>" >> /var/www/jsp/helloWorld.jsp
HEREDOC
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_eip" "default" {
  vpc = true

  instance                  = aws_instance.phpapp.id
  #associate_with_public_ip  = "10.0.0.12"
  depends_on                = [aws_internet_gateway.gw]
=======
resource "aws_instance" "phpapp" {
  ami           = lookup(var.AmiLinux, var.region)
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = aws_subnet.PublicAZA.id
  vpc_security_group_ids = [aws_security_group.WebApp.id]
  #key_name = var.key_name
  key_name = "Testkey"
  tags = {
        Name = "ec2_devops"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  yum install -y tomcat
  service tomcat start
  chkconfig tomcat on
  echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>JavaScript Hello World Example</title>
    <script src="js/app.js"></script>
</head>
<body>

</body>
</html>" >> /var/www/jsp/myApp.js
HEREDOC
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_eip" "default" {
  vpc = true

  instance                  = aws_instance.phpapp.id
  #associate_with_public_ip  = "10.0.0.12"
  depends_on                = [aws_internet_gateway.gw]
}