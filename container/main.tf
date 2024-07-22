resource "random_string" "random" {
  count   = var.count_in
  length  = 6
  lower   = true
  special = false
}


resource "docker_container" "app_container" {
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  count = var.count_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      volume_name    = module.volume[count.index].volume_output[volumes.key]
      container_path = volumes.value["container_path_each"]
    }

  }
  provisioner "local-exec" {
    when    = create
    command = "echo ${self.name}:${join(":", [self.network_data[0].ip_address, self.ports[0].external])} >> container.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f container.txt"
  }
}

module "volume" {
  source = "./volume"
  count = var.count_in
  volume_count = length(var.volumes_in)
  volume_name = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
  
  
}