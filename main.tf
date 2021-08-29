# resource "docker_image" "nodered_image" {
#   #name = "nodered/node-red:latest-minimal"
#   # using lookups
#   name = lookup(var.image, terraform.workspace)
# }

module "image" {
  source = "./image"
}

resource "docker_container" "nodered_container" {
 count = local.container_count
 # using random string
 name = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
 # Referencing other resources
 image = module.image.image_output
 ports {
   internal = var.int_port
   external = lookup(var.ext_port, terraform.workspace)[count.index]
 }
 volumes {
    host_path = "${path.cwd}/noderedvol"   # String Interpolation
    container_path = "/data" # changes made to flows are persisted
  }
}

# random resource
resource "random_string" "random" {
  count = local.container_count
  length = 8
  upper = false
  special = false
}

resource "null_resource" "dockerval" {
  provisioner "local-exec" {
    command = "mkdir noderedvol || true && sudo chown -R 1000:1000 noderedvol/"
  }
}