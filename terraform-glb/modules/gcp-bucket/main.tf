resource "google_storage_bucket" "bucket" {

  name = var.bucket_name
  storage_class = "STANDARD"
  location = var.bucket_location

  force_destroy = true
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.bucket.name
  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}



