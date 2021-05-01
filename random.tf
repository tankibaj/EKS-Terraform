resource "random_pet" "this" {}

resource "random_string" "this" {
  length  = 8
  special = false
}