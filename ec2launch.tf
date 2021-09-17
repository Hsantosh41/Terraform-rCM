provider "aws" {
   region     = "us-west-1"
   access_key = "AKIA567PIMJWCADGCUNX"
   secret_key = "IEof4dw40KneIM39/DBVQUAScgkQz9ioVhl5X77E"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-07a02ba61447a61d2"
    count = 2
    instance_type = "t2.micro"
    
    tags = {
      Name = "PHP-${count.index}"
    }
    key_name = "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/root/script.sh"
    destination = "/home/ubuntu/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/script.sh",
      "/home/ubuntu/script.sh args",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/root/.ssh/aws_key")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+Kkb2uv8IR+EZJ4Z0dpeR0uOuI1sF/vLvIbSaka3YMfUOqr+2RY8DdrVME+CJvo5DrJt3u+SSv01tBgub0vPtkZ2vgKT6X+To4Oqfe6KLF6w4k4oCKebZD6vC7IEQ4fJNcXgrVT3xoEr+zyRgmfZBvQNpLa0ZJdO08pDj5Y+pyuF+De9uAWZ20d2KbERF+pnN9Ufg+MLi86vpmqiCxyg+jXazgQIPk6lzbX/kZJXTr04KHzGJUY0Hvq50YilfRMfd/AYEIRYiACXW7ZZxKi9A14dtDhefT88spsSA+eie8jKNT6GCd0S1cep2shEMKsVhhypirxtEXm762seIpw2KpCzVHoLHlKV13Eukxu48UpLkBWJ23yQ9DI6T9wFZfn3iH632d0LwUrDqwaudARmMHMYceENHigzCGEb/u0AUQ+Y+K+9NUJMeQ324oOKhql4ynGFVc8HBY+2khtyaovgxxMBolSM+KVUbfj93y3qBaW/URjk2zwe8YG3gMKW33eU= root@hemanth-VirtualBox"
}
