variable "environment" {
  description = "Project env"
  type        = string
  default     = "dev"
}


variable "teste" {
  type        = map(string)
  default     = {
     chave = "valor"
  }
}