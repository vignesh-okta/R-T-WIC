

module "app_signon_policies" {
  source                  = "./modules/app_signon_policies"
  app_signon_policy_map   = local.app_signon_policies_map
  group_name_id_map       = local.group_name_id_map
  networkzone_name_id_map = module.network_zones.networkzones_name_id_map
}

module "applications" {
  source                        = "./modules/applications"
  applications_oauth_map        = local.applications_map
  images_dir                    = "./input_files/images"
  app_signon_policy_name_id_map = module.app_signon_policies.app_signon_policy_name_id_map
}

module "groups" {
  source     = "./modules/groups"
  groups_map = local.groups_map.groups
}

module "network_zones" {
  source            = "./modules/network_zones"
  network_zones_map = local.network_zones_map
  threatinsight_network_exclude = "RnT Owned Address Space"
}

module "global_signon_policies" {
  source                     = "./modules/global_signon_policies"
  group_name_id_map          = local.group_name_id_map
  global_signon_policies_map = local.global_signon_policies_map
  networkzone_name_id_map    = module.network_zones.networkzones_name_id_map
}

module "password_policy" {
  source              = "./modules/password_policy"
  password_policy_map = local.password_policies_map
  groups_name_id_map = local.group_name_id_map
}

module "authenticators" {
  source             = "./modules/authenticators"
  authenticators_map = local.authenticators_map.authenticators
}

module "authenticators_enroll_policies" {
  source                            = "./modules/authenticators_enroll_policies"
  authenticator_enroll_policies_map = local.authenticators_enroll_policies_map
  group_name_id_map                 = local.group_name_id_map
  networkzone_name_id_map           = module.network_zones.networkzones_name_id_map
  depends_on                        = [module.groups, module.authenticators]
}

resource "okta_security_notification_emails" "security_notification" {
  report_suspicious_activity_enabled       = true
  send_email_for_factor_enrollment_enabled = true
  send_email_for_factor_reset_enabled      = true
  send_email_for_new_device_enabled        = true
  send_email_for_password_changed_enabled  = true
}

module "group_rules" {
  source            = "./modules/group_rules"
  group_name_id_map = local.group_name_id_map
  group_rules_map   = local.group_rules_map.group_rules_map
  depends_on        = [module.groups, module.user_custom_schema_properties]
}

module "user_custom_schema_properties" {
  source                        = "./modules/user_custom_schema_properties"
  user_custom_schema_properties = local.user_custom_schema_properties
  app_name_id_map               = merge(module.applications.app_name_id_map)
  user_type_name_id_map         = {}
}

module "email_customizations" {
  source                             = "./modules/email_customizations"
  email_customizations_map           = local.email_customizations_map
  brand_id                           = var.OKTA_BRAND_ID
  email_customizations_templates_dir = "./input_files/email_custom_templates"
}

module "custom_admin_roles" {
  source            = "./modules/custom_admin_roles"
  admin_roles_map   = local.custom_admin_roles
  app_label_id_map  = module.applications.app_name_id_map
  group_name_id_map = local.group_name_id_map
  OKTA_ORG_NAME     = var.OKTA_ORG_NAME
  OKTA_BASE_URL     = var.OKTA_BASE_URL
  depends_on        = [module.groups]
}

