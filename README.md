# terraform-module-ovh-kms

Terraform module to manage OVH KMS (Key Management Service) resources.

## Description

This module creates and configures an OVH KMS and manages access credentials using `ovh_okms_credential`.

## Prerequisites

- Terraform >= 1.0.0
- OVH provider >= 2.8.0
- OVH credentials configured (via environment variables or configuration file)

## Required environment variables

```bash
export OVH_ENDPOINT=ovh-eu
export OVH_APPLICATION_KEY=your_application_key
export OVH_APPLICATION_SECRET=your_application_secret
export OVH_CONSUMER_KEY=your_consumer_key
```

## Usage

### Minimal example

```hcl
module "kms" {
  source = "git::https://github.com/ansforge/terraform-module-ovh-kms.git?ref=ovh/v1.0.0"

  kms_key_name           = "my-kms-key"
  region                 = "eu-west-rbx"
  create_credential      = true
  credential_name        = "my-credential"
  credential_description = "Credential for accessing KMS"
  identity_urns          = ["urn:v1:eu:identity:account:example-ovh"]
}
```

### Full example

```hcl
module "kms" {
  source = "git::https://github.com/ansforge/terraform-module-ovh-kms.git?ref=ovh/v1.0.0"

  kms_key_name             = "production-kms"
  region                   = "eu-west-rbx"
  create_credential        = true
  credential_name          = "prod-credential"
  credential_description   = "Production KMS access credential"
  identity_urns            = [
    "urn:v1:eu:identity:account:1111-ovh",
    "urn:v1:eu:identity:user:1111-ovh/user.name"
  ]
}

output "kms_endpoint" {
  value = module.kms.kms_rest_endpoint
}

output "credential_cert" {
  value     = module.kms.credential_certificate_pem
  sensitive = true
}
```

### Example without creating a credential

```hcl
module "kms" {
  source = "git::https://github.com/ansforge/terraform-module-ovh-kms.git?ref=ovh/v1.0.0"

  kms_key_name      = "my-kms-key"
  region            = "eu-west-rbx"
  create_credential = false
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `project_id` | OVH project ID (optional) | `string` | `""` | no |
| `region` | OVH region for the KMS | `string` | `"eu-west-rbx"` | no |
| `kms_key_name` | Name of the KMS to create | `string` | `"ovh-kms-key"` | no |
| `create_credential` | Create a KMS credential for access | `bool` | `true` | no |
| `credential_name` | Name of the KMS credential | `string` | `"kms-credential"` | no |
| `credential_description` | Description of the KMS credential | `string` | `"KMS access credential"` | no |
| `identity_urns` | List of identity URNs allowed to use this credential | `list(string)` | `[]` | no |
| `credential_validity_from` | Credential validity start date (RFC3339 format) | `string` | `null` | no |
| `credential_validity_to` | Credential validity end date (RFC3339 format) | `string` | `null` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|----------|
| `kms_id` | ID of the created KMS | no |
| `kms_urn` | URN of the KMS | no |
| `kms_region` | Region of the KMS | no |
| `kms_rest_endpoint` | REST endpoint of the KMS | no |
| `kms_swagger_endpoint` | Swagger endpoint of the KMS | no |
| `kms_kmip_endpoint` | KMIP endpoint of the KMS | no |
| `credential_id` | ID of the created credential | no |
| `credential_name` | Name of the credential | no |
| `credential_certificate_pem` | PEM content of the credential certificate | yes |
| `credential_private_key_pem` | PEM content of the credential private key | yes |

## Using the credential

Once the credential is created, you can use the generated certificate and private key to access the KMS via the REST or KMIP endpoint.

Example with curl:
```bash
curl --cert credential.pem --key credential-key.pem \
  https://<kms_rest_endpoint>/v1/servicekey
```

## License

See [LICENSE](LICENSE) in the parent repository.
