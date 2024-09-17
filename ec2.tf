# Resource-8: Create jenkins EC2 Instance
resource "aws_instance" "jenkins-vm" {
    ami = var.ec2_ami_id
    instance_type = var.ec2_instance_type
    key_name = "Docker"
    count = 1
    subnet_id = aws_subnet.Infra-vpc-public-subnet-1.id
    vpc_security_group_ids = [aws_security_group.Infra-vpc-sg.id]
    # user_data = file("jenkins-install.sh")
     user_data = <<-EOF
         #!/bin/bash
         # Update the package list
         sudo apt-get update -y

         # Install Jenkins
         sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
         https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
         echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
         https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
         /etc/apt/sources.list.d/jenkins.list > /dev/null
         sudo apt-get update
         sudo apt-get install fontconfig openjdk-17-jre
         sudo apt-get install jenkins
  
         # Install Maven
         sudo apt update
         sudo apt install maven -y
       EOF  

    tags = {
      "Name" = "jenkins-vm"
    }

    root_block_device {
      volume_size = var.volume
    }
}