variable "image" {
  type        = map(any)
  description = "Image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana-enterprise"
      prod = "grafana/grafana-enterprise"
    }
  }
}


variable "ext_port" {
  type = map(any)
  # validation {
  #   condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
  #   error_message = "The external port must be in the valid ramge of 0 - 65535"
  # }

  #   validation {
  #   condition = max(var.ext_port["prod"]...) <= 1980 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "The external port must be in the valid ramge of 0 - 65535"
  # }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880"
  }
}
