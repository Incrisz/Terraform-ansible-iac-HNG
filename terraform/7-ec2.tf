resource "aws_instance" "ec2-worker1" {
    ami = "ami-091f18e98bc129c4e"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [ aws_security_group.sg_custom.id ]
    key_name = "devops"

    root_block_device {
        volume_size = 15  # Storage size in GiB (Modify as needed)
        volume_type = "gp3"  # Optional: Change to gp2, io1, etc.
        delete_on_termination = true  # Optional: Delete storage when instance is terminated
    }
  provisioner "local-exec" {
    command = <<EOT
      echo "[my_cloud_server]" > ../ansible/inventory.ini
      echo "worker1 ansible_host=${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/cloud/Videos/Terraform-ansible-iac-HNG/devops.pem " >> ../ansible/inventory.ini
    EOT
  }

    # Tag the instance as "ec2-worker1" to differentiate it from other instances.
    tags = {
        "Name" = "ec2-worker1"
    }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-worker1.public_ip
}
