## Terrahome AWS

```c
module "home_visit_ghana" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.visit_ghana_public_path
  content_version = var.content_version
}
```
The public Directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not any sub directories.