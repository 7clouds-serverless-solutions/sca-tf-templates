module "content_bucket_allow_policy" {
  source  = "7clouds-terraform-modules/iam-policy/aws"
  version = "0.1.0"

  POLICY_ACTION      = var.POLICY_ACTION_CONTENT_BUCKET_ALLOW
  POLICY_EFFECT      = var.POLICY_EFFECT_CONTENT_BUCKET_ALLOW
  POLICY_RESOURCE    = ["${module.content_management_bucket.BUCKET_ARN}", "${module.content_management_bucket.BUCKET_ARN}/*"]
  POLICY_NAME        = var.POLICY_NAME_CONTENT_BUCKET_ALLOW
  POLICY_DESCRIPTION = var.POLICY_DESCRIPTION_CONTENT_BUCKET_ALLOW
}

module "content_management_bucket" {
  source  = "7clouds-terraform-modules/s3-bucket/aws"
  version = "0.1.2"

  PROJECT_NAME                         = module.tags.PROJECT_NAME
  CREATE_BUCKET                        = var.CREATE_CONTENT_MANAGEMENT_BUCKET
  CONTENT_BUCKET                       = var.CONTENT_MANAGEMENT_BUCKET_NAME
  CONTENT_BUCKET_FORCE_DESTROY         = var.CONTENT_MANAGEMENT_BUCKET_FORCE_DESTROY
  BUCKET_ACL                           = var.CONTENT_MANAGEMENT_BUCKET_ACL
  BLOCK_PUBLIC_ACLS                    = var.CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_ACLS
  BLOCK_PUBLIC_POLICY                  = var.CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_POLICY
  IGNORE_PUBLIC_ACLS                   = var.CONTENT_MANAGEMENT_BUCKET_IGNORE_PUBLIC_ACLS
  RESTRICT_PUBLIC_BUCKETS              = var.CONTENT_MANAGEMENT_BUCKET_RESTRICT_PUBLIC_BUCKETS
  SERVER_SIDE_ENCRYPTION_CONFIGURATION = var.CONTENT_MANAGEMENT_BUCKET_SERVER_SIDE_ENCRYPTION_CONFIGURATION
  BUCKET_VERSIONING                    = var.CONTENT_MANAGEMENT_BUCKET_VERSIONING
  TAGS                                 = module.tags.TAGS
}

module "lambda_ecr_api_gateway" {
  source = "7clouds-terraform-modules/lambda-ecr-api-gateway/aws"
  version = "0.1.0"

  PROJECT_NAME                        = var.TAGS_MODULE.PROJECT_NAME
  ENVIRONMENT                         = var.TAGS_MODULE.ENVIRONMENT
  SECURITY_GROUP_IDS                  = var.SECURITY_GROUP_IDS
  SUBNET_IDS                          = var.SUBNET_IDS
  API_GATEWAY_RESOURCE_PATH           = var.API_GATEWAY_RESOURCE_PATH_LAMBDA_API
  ECR_REPOSITORY_NAME                 = var.ECR_REPOSITORY_NAME_LAMBDA_API
  ECR_IMAGE_TAG                       = var.ECR_IMAGE_TAG_LAMBDA_API
  TAGS                                = module.tags.TAGS
  WARMUP_ENABLED                      = var.WARMUP_ENABLED_LAMBDA_API
  LAMBDA_WARMUP_SCHEDULE_EXPRESSION   = var.LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API
  MEMORY_SIZE                         = var.MEMORY_SIZE_LAMBDA_API
  TIMEOUT                             = var.TIMEOUT_LAMBDA_API
  ENVIRONMENT_VARIABLES               = merge({ content_bucket = module.content_management_bucket.CONTENT_BUCKET }, var.ENVIRONMENT_VARIABLES_LAMBDA_API)
  ATTACHED_POLICY_ARNS                = concat([module.content_bucket_allow_policy.IAM_POLICY_ARN], var.LAMBDA_MANAGED_POLICIES_ARN_LIST)
  API_GATEWAY_METHOD_AUTHORIZATION    = var.API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API
  API_GATEWAY_METHOD_HTTP_METHOD      = var.API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API
  API_GATEWAY_INTEGRATION_HTTP_METHOD = var.API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API
  API_GATEWAY_INTEGRATION_INPUT_TYPE  = var.API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API
}

module "waf_standard" {
  source  = "7clouds-terraform-modules/waf-standard/aws"
  version = "0.1.0"

  PROJECT_NAME                          = var.TAGS_MODULE.PROJECT_NAME
  WAF_WEB_ACL_SCOPE                     = var.WAF_WEB_ACL_SCOPE_STANDARD
  WAF_SCOPE_CLOUDWATCH_METRICS          = var.WAF_SCOPE_CLOUDWATCH_METRICS_STANDARD
  WAF_SCOPE_SAMPLED_REQUESTS            = var.WAF_SCOPE_SAMPLED_REQUESTS_STANDARD
  WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST = [module.lambda_api_gateway.API_GATEWAY_STAGE_ARN]
  RULES                                 = var.RULES_WAF_STANDARD
}

module "elasticache_memcached" {
  source  = "7clouds-terraform-modules/elasticache/aws"
  version = "0.1.0"

  PROJECT_NAME          = var.TAGS_MODULE.PROJECT_NAME
  SUBNET_GROUP_NAME     = var.ELASTICACHE_SUBNET_GROUP_NAME
  SUBNET_GROUP_IDS_LIST = []

  CLUSTER_ID                  = lower("${var.TAGS_MODULE.PROJECT_NAME}-memcached")
  CLUSTER_ENGINE              = var.ELASTICACHE_CLUSTER_ENGINE
  CLUSTER_NODE_TYPE           = var.ELASTICACHE_CLUSTER_NODE_TYPE
  CLUSTER_NUM_CACHE_NODES     = var.ELASTICACHE_CLUSTER_NUM_CACHE_NODES
  CLUSTER_PORT_NUMBER         = var.ELASTICACHE_CLUSTER_PORT_NUMBER
  CLUSTER_SECURITY_GROUPS_IDS = []
  TAGS                        = module.tags.TAGS
}

module "tags" {
  source  = "7clouds-terraform-modules/tags/aws"
  version = "0.1.1"

  AWS_REGION      = var.TAGS_MODULE.AWS_REGION
  PROJECT_NAME    = var.TAGS_MODULE.PROJECT_NAME
  ENVIRONMENT     = var.TAGS_MODULE.ENVIRONMENT
  COMPANY         = var.TAGS_MODULE.COMPANY
  OWNER           = var.TAGS_MODULE.OWNER
  PROJECT_TYPE    = var.TAGS_MODULE.PROJECT_TYPE
  PROJECT_VERSION = var.TAGS_MODULE.PROJECT_VERSION
  LOB             = var.TAGS_MODULE.LOB
  APP_ID          = var.TAGS_MODULE.APP_ID
}
