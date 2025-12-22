


resource "aws_security_group" "firewall" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  
  
  

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Jenkins web interface"

  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access"
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SonarQube access"
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SonarQube access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}





resource "aws_instance" "Jenkins" {
  ami                    = var.ami
  for_each               = var.instance
  instance_type          = each.value
  root_block_device {
    volume_size = 30
    
  }
  
  
  
  vpc_security_group_ids = [aws_security_group.firewall.id]
  tags = {
        Name = each.key
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install wget zip -y
              sudo yum install java-17-amazon-corretto -y java -version

              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              
              
              sudo yum install jenkins -y
              sudo systemctl enable jenkins
              sudo systemctl start jenkins

              sudo yum install git -y
              sudo yum install docker -y                
              sudo service docker start
              sudo usermod -a -G docker ec2-user
             
            
              EOF
    
}

