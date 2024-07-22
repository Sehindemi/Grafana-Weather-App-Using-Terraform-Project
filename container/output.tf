# output "container-name" {
#   value = docker_container.nodered_container.name
#   description = "The name of the container"
# }

# output "ip-address" {
#   value = [ for i in docker_container.nodered_container[*]: join(":", [i.network_data[0].ip_address, i.ports[0].external])]
#   description = "The IP Adress and external port of the container"
# }

output "application_access" {
  value = { for i in docker_container.app_container[*] : i.name => join(":", [i.network_data[0].ip_address, i.ports[0]["external"]]) }
}