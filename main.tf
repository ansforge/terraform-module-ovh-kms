resource "ovh_okms" "kms" {
  ovh_subsidiary = "FR"
  display_name   = var.kms_key_name
  region         = var.region
}

resource "ovh_okms_credential" "kms_credential" {
  count = var.create_credential ? 1 : 0

  okms_id          = ovh_okms.kms.id
  name             = var.credential_name
  description      = var.credential_description
  identity_urns    = var.identity_urns
  certificate_type = var.certificate_type
}
