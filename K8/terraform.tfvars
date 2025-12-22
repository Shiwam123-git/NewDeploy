ami           = "ami-068c0051b15cdb816"
instance_type = "t3.micro"
region        = "us-east-1"
instance = {
  "jenkins"   = "t3.micro"
  "Sonarqube" = "t3.micro"
  "Nexus"     = "t3.micro"
}