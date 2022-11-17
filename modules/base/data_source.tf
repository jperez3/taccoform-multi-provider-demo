data "aws_route53_zone" "selected" {
  name = "${var.domain}."
}

data "cloudflare_zone" "selected" {
  name = var.domain
}

data "digitalocean_ssh_key" "root" {
  name = "taccoform-tutorial"
}
