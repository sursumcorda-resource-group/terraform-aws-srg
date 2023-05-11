variable "name" {
  type = string
}

variable "policy" {
  type = string
  default = null
}

variable "logging" {
    type = object({
      bucket_id = string
      bucket_prefix = string
    })
    default = null  
}