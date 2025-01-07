packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ec2" {
  ami_name      = "rhel-golden-image"
  instance_type = "t3.small"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "RHEL-9-DevOps-Practice"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["973714476881"]
  }
  ssh_username = "ec2-user"
  ssh_password = "DevOps321"
}

build {
  sources = [
    "source.amazon-ebs.ec2"
  ]

  provisioner "shell" {
    inline = [
      "sudo labauto ansible"
    ]
  }
}
