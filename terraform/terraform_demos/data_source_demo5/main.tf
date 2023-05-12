terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

provider "local" {
  # Configuration options
}

data "local_file" "foo"{
    filename = "${path.module}/foo.txt"
}

output "filecontent" {
  value = data.local_file.foo.content
}