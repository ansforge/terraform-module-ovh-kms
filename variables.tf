variable "region" {
  description = "OVH region for the KMS resource ('eu-west-rbx')."
  type        = string
  default     = "eu-west-rbx"
}

variable "kms_key_name" {
  description = "Name of the KMS key to create (informational)."
  type        = string
  default     = "ovh-kms-key"
}

variable "kms_subsidiary" {
  description = "OVH subsidiary for the KMS resource."
  type        = string
  default     = "FR"
}

variable "create_credential" {
  description = "Whether to create a KMS credential for access."
  type        = bool
  default     = true
}

variable "certificate_type" {
  description = "Type of certificate for the KMS credential."
  default     = "ECDSA"
}

variable "credential_name" {
  description = "Name of the KMS credential."
  type        = string
  default     = "kms-credential"
}

variable "credential_description" {
  description = "Description of the KMS credential."
  type        = string
  default     = "KMS access credential"
}

variable "identity_urns" {
  description = "List of identity URNs allowed to use this credential."
  type        = list(string)
  default     = []
}
