# printing the output
output "container_name" {
  value = docker_container.nodered_container[*].name # using splat expression: value[index] changed to value[*]
  description = "Name of the Docker Container"
}
output "ip_address" {
  # terraform function
  #value = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].internal])
  value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address, i.ports[0]["external"]])]
  description = "The IP address and internal port of Docker Container"
  #sensitive = true
}
