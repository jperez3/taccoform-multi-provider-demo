resource "aws_route53_record" "cloudflare_cname" {
  name    = "salsa.${var.domain}"
  records = ["salsa.${var.domain}.cdn.cloudflare.net"]
  ttl     = 300
  type    = "CNAME"
  zone_id = data.aws_route53_zone.selected.zone_id
}



resource "cloudflare_record" "origin" {
  name    = "salsa"
  value   = digitalocean_droplet.web.ipv4_address
  type    = "A"
  ttl     = 3600
  zone_id = data.cloudflare_zone.selected.id
}



resource "digitalocean_droplet" "web" {
  image     = "ubuntu-20-04-x64"
  name      = "web1-salsa-${var.env}"
  region    = "sfo2"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [data.digitalocean_ssh_key.root.id]
  user_data = templatefile("${path.module}/templates/user_data_nginx.yaml", { hostname = "web1-salsa-${var.env}" })
}
