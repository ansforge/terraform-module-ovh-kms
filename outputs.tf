output "kms_id" {
  description = "KMS ID."
  value       = ovh_okms.kms.id
}

output "kms_region" {
  description = "Region of the KMS resource."
  value       = ovh_okms.kms.region
}

output "kms_rest_endpoint" {
  description = "REST endpoint for the KMS."
  value       = ovh_okms.kms.rest_endpoint
}

output "kms_swagger_endpoint" {
  description = "Swagger endpoint for the KMS."
  value       = ovh_okms.kms.swagger_endpoint
}

output "kms_kmip_endpoint" {
  description = "KMIP endpoint for the KMS."
  value       = ovh_okms.kms.kmip_endpoint
}

output "credential_id" {
  description = "ID of the created KMS credential."
  value       = var.create_credential && length(ovh_okms_credential.kms_credential) > 0 ? ovh_okms_credential.kms_credential[0].id : null
}

output "credential_name" {
  description = "Name of the KMS credential."
  value       = var.create_credential && length(ovh_okms_credential.kms_credential) > 0 ? ovh_okms_credential.kms_credential[0].name : null
}

output "credential_certificate_pem" {
  description = "PEM content of the credential certificate."
  value       = var.create_credential && length(ovh_okms_credential.kms_credential) > 0 ? ovh_okms_credential.kms_credential[0].certificate_pem : null
  sensitive   = true
}

output "credential_private_key_pem" {
  description = "PEM content of the credential private key."
  value       = var.create_credential && length(ovh_okms_credential.kms_credential) > 0 ? ovh_okms_credential.kms_credential[0].private_key_pem : null
  sensitive   = true
}
