terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.2.0"
}

# Windows
provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

# Mac or Linux
# provider "docker" { }

resource "docker_image" "nginx" {
  name         = "nginx:1.23"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-container"
  ports {
    internal = 80
    external = 8000
  }
}
