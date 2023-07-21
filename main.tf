provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "terraform" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = var.ec2_instance_type
  key_name = "terraformSSH" # SSH key generated in advance

  # To connect via ssh key do this
    # chmod 400 terraformSSH.pem
    # ssh -i terraformSSH.pem ec2-35-173-27-54.compute-1.amazonaws.com
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.private-interface.id
  }

  # install some software during deployment
  user_data = <<-EOF
    #!/bin/bash
    sudo su
    sudo apt-get update -y
    sudo apt-get upgrade -y
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install ncdu
    brew install tree
  EOF

  tags = {
    Name = "My First instance"
  }
}
