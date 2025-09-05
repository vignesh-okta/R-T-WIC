variable "OKTA_ORG_NAME" {}
variable "OKTA_BASE_URL" {}
variable "OKTA_BRAND_ID" {}
# variable "OKTA_API_TOKEN" {}

locals {

  applications_map = jsondecode(replace(templatefile("input_files/applications/applications.tftpl", { appDirPath = "${path.module}", pattern = "input_files/applications/*.json" }), ",]}", "]}"))

  app_signon_policies_map = jsondecode(file("./input_files/app_signon_policies.json"))

  authenticators_map = jsondecode(file("./input_files/authenticators.json"))

  authenticators_enroll_policies_map = jsondecode(file("./input_files/authenticators_enroll_policies.json"))

  groups_map = jsondecode(file("./input_files/groups.json"))

  group_rules_map = jsondecode(file("./input_files/group-rules.json"))

  custom_admin_roles = jsondecode(file("./input_files/custom_admin_roles.json"))

  email_customizations_map = jsondecode(file("./input_files/email_customizations.json"))

  user_custom_schema_properties = jsondecode(file("./input_files/user_custom_schema_properties.json"))

  network_zones_map = jsondecode(file("./input_files/network_zones.json"))

  global_signon_policies_map = jsondecode(file("./input_files/global_signon_policies.json"))

  group_name_id_map = module.groups.group_name_id_map

  password_policies_map = jsondecode(file("./input_files/password_policies.json"))


}

