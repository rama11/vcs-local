variable "VSPHERE_USER" {
  description = "Value of user that have administrator access"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "VSPHERE_PASSWORD" {
  description = "Value of password from the user"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "VSPHERE_SERVER" {
  description = "Value of vSphare Server Local"
  type        = string
  default     = "ExampleAppServerInstance"
}
