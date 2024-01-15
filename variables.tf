variable "environment" {
  description = "Project env"
  type        = string
  default     = "prd"
}


variable "teste" {
  type = map(string)
  default = {
    chave = "valor"
  }
}