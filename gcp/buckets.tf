resource "google_storage_bucket" "auto-expire" {
  name          = "bucket-posgrad-iac-gus"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}