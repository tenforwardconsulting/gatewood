terraform {
  # Default backend is just local.

  # Uncomment to use s3
  # backend "s3" {
  #   bucket = "subspace-backend-gatewood"
  #   key    = "subspace.production.tfstate"
  #   region = "us-west-2"
  # }

  # Uncomment to use Terraform Cloud
  cloud {
    organization = "tenforward"

    workspaces {
      name = "gatewood"
    }
  }

}

module workhorse {
  source = "github.com/tenforwardconsulting/terraform-subspace-workhorse?ref=main"
  project_name = "gatewood"
  project_environment = "production"
  aws_region = "us-west-2"
  subspace_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtnAeu95jN+0ofgXwUAucUHESq9T3cxV75Wr5dCOhrAakntPDjfQTtMdDcVhwlHhxk62GtFQu/u8cA+4ni/XPztCUStryHA54OXpYoHwwZtTkC9f77x+MySUQRhkAb5r/vQ/JBl5a+SVVUkeUFFUHtMPCgfzSZtA/SwH5mYLAwc1ioIl/t3+b3R5aDZXogu4zQnAAmt+zdSZD6PJxoKm20BDwzhORNTWsxY06U25Xcv3mxCoj2+cVTPmppx0sn6Z6wJKZwWger1JeM+K4Vj9vsnZLrAYeQ93WgaDX3pKdn8rOd18/E/quiitb2pKk72By9KdWyRo6TpKQZdtL5NiI65kP1yFjq+XFmrymbDXggRp9n25FazXgj/R1/7UYxrLvIcSqx1T7P4mR6QKoHAoStUmfQ/7oVkAZtQ4HuAjYvByXrBY3ku2LEM3+VbqwEYjZxTkmKuyhhqG38p5fC+kTmJsfg8jEoO5n8RtBkl+/u/Jf2bMfHtK+c0RsETzrrU70= bsamson@naomi"
  zone_id = "ZOJ6811VRVYBT" # 10fw.net
  subdomain = "gatewood"

  # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_ami = "ami-0f81e6e71078b75b6"
  instance_user = "ubuntu"
  instance_type = "t3.small"
  instance_hostname = "gatewood-production"
  instance_volume_size = 20
}

output "workhorse" {
  value = module.workhorse
}

output "inventory" {
  value = module.workhorse.inventory
}

