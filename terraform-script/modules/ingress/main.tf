resource "null_resource" "install_ingress" {
  triggers = {
    master_public_ip = var.master_public_ip
  }

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = var.master_public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml"
    ]
  }
}
