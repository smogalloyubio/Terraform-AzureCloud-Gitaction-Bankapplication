resource "null_resource" "install_ingress" {
  triggers = {
    master_public_ip = var.master_public_ip
  }

  connection {
    type        = "ssh"
    user        = "azureuser"
    host        = var.master_public_ip
    private_key = file(var.ssh_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml"
    ]
  }
}
