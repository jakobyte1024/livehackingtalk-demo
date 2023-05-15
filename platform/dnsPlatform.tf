resource "google_dns_record_set" "msver" {
  name         = "configs.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "TXT"
  ttl          = 10

  rrdatas = [
                "MS=ms894daf5",
                "v=spf1 include:spf.protection.outlook.com -all",
                "facebook-domain-verification=21t-5165afb41-535120-306f",
                "have-i-been-pwned-verification=464b1e3306ffffb1230a99aec7d43218"
            ]
}

resource "google_dns_record_set" "mso1" {
  name         = "autodiscover.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "CNAME"
  ttl          = 10

  rrdatas = ["autodiscover.outlook.com."]
}

resource "google_dns_record_set" "stageCnApp" {
  name         = "${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "CNAME"
  ttl          = 10

  rrdatas = ["app.${data.google_dns_managed_zone.env_dns_zone.dns_name}"]
}

resource "google_dns_record_set" "stageCnMail" {
  name         = "mail.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = ["147.190.40.48"]
}

resource "google_dns_record_set" "stageCnVpn" {
  name         = "vpngateway.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = ["64.244.87.126"]
}

resource "google_dns_record_set" "stageCnNexus" {
  name         = "nexus.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = ["169.98.119.82"]
}

resource "google_dns_record_set" "stageCnDev5" {
  name         = "dev5.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = ["50.18.233.63"]
}