resource "docker_image" "nodered_image" {
  #name = "nodered/node-red:latest-minimal"
  # using lookups
  name = "nodered/node-red:latest"
 }