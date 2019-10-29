

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-east-2"
}

resource "aws_instance" "aws-lnx-1" {
  ami           = "ami-0c64dd618a49aeee8"
  instance_type = "t2.micro"
  key_name = "id_rsa_msa"

connection {
        user = "ec2-user"
        type = "ssh"
        private_key = "${file("~/.ssh/id_rsa_msa")}"
        timeout = "2m"
        host = "${self.public_ip}"
}
    
    provisioner "remote-exec" {
        inline = [
          "sleep 25",
          "sudo yum update -y",
          "sudo yum install git -y",
          "sudo yum install nginx -y",
          "sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index2.html",
          "sudo git clone https://github.com/BlackrockDigital/startbootstrap-bare.git",
          "sudo cp -r startbootstrap-bare/. /usr/share/nginx/html",
          "sudo service nginx start"
          
          ]
}


}
