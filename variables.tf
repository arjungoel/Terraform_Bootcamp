# variable "env" {
#     type = string
#     description = "Env to deploy to"
#     default = "dev"
# }

variable "image" {
    type = map
    description = "docker image for containers"
    default = {
        dev = "nodered/node-red:latest"
        prod = "nodered/node-red:latest-minimal"
    }
}

variable "ext_port" {
  type = map
  #sensitive = true
  
  # custom validation
   validation {
    condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980     # man, mix function and expand expression
    error_message = "The external port must be in the valid port range from 0-65535."
   }
   validation {
    condition = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880       # man, mix function and expand expression
    error_message = "The external port must be in the valid port range from 0-65535."
   }
}

variable "int_port" {
  type = number
  #sensitive = true
}

# variable "container_count" {
#   type = number
#   default = 1
# }

locals {
    container_count = length(lookup(var.ext_port, terraform.workspace)) #+ 2
}