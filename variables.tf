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

variable "teste_ports" {
  type = map(object({
    description = string
    cidr_blocks = list(string)
  }))

  default = {
    22 = {
      description = "SSH"
      cidr_blocks = ["0.0.0.0/0"]
    }

    80 = {
      description = "http"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "teste_ports2" {
  type = list(string)

  default =  ["0.0.0.0/0", "1.1.1.1/1"]
}