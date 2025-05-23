module "base_networking" {
  source  = "7clouds-terraform-modules/base-networking/aws"
  version = "0.1.2"

  PROJECT_NAME                    = var.TAGS_MODULE.PROJECT_NAME
  AZ_COUNT                        = var.AZ_COUNT_BASE_NETWORKING
  VPC_CIDR                        = var.VPC_CIDR_BASE_NETWORKING
  PUBLIC_SUBNETS_CIDR_BLOCK_LIST  = var.PUBLIC_SUBNETS_CIDR_BLOCK_LIST_BASE_NETWORKING
  PRIVATE_SUBNETS_CIDR_BLOCK_LIST = var.PRIVATE_SUBNETS_CIDR_BLOCK_LIST_BASE_NETWORKING
  PUBLIC_ROUTE_TABLE_CIDR_BLOCK   = var.PUBLIC_ROUTE_TABLE_CIDR_BLOCK_BASE_NETWORKING
  PRIVATE_ROUTE_TABLES_CIDR_BLOCK = var.PRIVATE_ROUTE_TABLES_CIDR_BLOCK_BASE_NETWORKING
}

module "cloudwatch_disable_policy" {
  source  = "7clouds-terraform-modules/iam-policy/aws"
  version = "0.1.0"

  POLICY_ACTION      = var.POLICY_ACTION_CLOUDWATCH_DISABLE
  POLICY_EFFECT      = var.POLICY_EFFECT_CLOUDWATCH_DISABLE
  POLICY_RESOURCE    = var.POLICY_RESOURCE_CLOUDWATCH_DISABLE
  POLICY_NAME        = var.POLICY_NAME_CLOUDWATCH_DISABLE
  POLICY_DESCRIPTION = var.POLICY_DESCRIPTION_CLOUDWATCH_DISABLE
}

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

module "logging_layers" {
  source  = "7clouds-terraform-modules/lambda-layer/aws"
  version = "0.1.0"

  COMPATIBLE_RUNTIMES = var.COMPATIBLE_RUNTIMES_LOGGING_LAYER
  LAYER_NAME          = var.LAYER_NAME_LOGGING_LAYER
  DESCRIPTION         = var.DESCRIPTION_LOGGING_LAYER
  FILENAME            = var.FILENAME_LOGGING_LAYER
}

module "logs_bucket" {
  source  = "7clouds-terraform-modules/s3-bucket/aws"
  version = "0.1.2"

  PROJECT_NAME                         = module.tags.PROJECT_NAME
  CREATE_BUCKET                        = var.CREATE_LOGS_BUCKET
  CONTENT_BUCKET                       = var.LOGS_BUCKET_NAME
  CONTENT_BUCKET_FORCE_DESTROY         = var.LOGS_BUCKET_FORCE_DESTROY
  BUCKET_ACL                           = var.LOGS_BUCKET_ACL
  BLOCK_PUBLIC_ACLS                    = var.LOGS_BUCKET_BLOCK_PUBLIC_ACLS
  BLOCK_PUBLIC_POLICY                  = var.LOGS_BUCKET_BLOCK_PUBLIC_POLICY
  IGNORE_PUBLIC_ACLS                   = var.LOGS_BUCKET_IGNORE_PUBLIC_ACLS
  RESTRICT_PUBLIC_BUCKETS              = var.LOGS_BUCKET_RESTRICT_PUBLIC_BUCKETS
  SERVER_SIDE_ENCRYPTION_CONFIGURATION = var.LOGS_BUCKET_SERVER_SIDE_ENCRYPTION_CONFIGURATION
  LOCALS_LIFECYCLE_RULES               = var.LOGS_BUCKET_LOCALS_LIFECYCLE_RULES
  TAGS                                 = module.tags.TAGS
}

module "centralized_logs" {
  source     = "7clouds-terraform-modules/lambda-centralized-logs/aws"
  version    = "0.1.2"
  depends_on = [module.logs_bucket]

  PROJECT_NAME                                         = module.tags.PROJECT_NAME
  LOGS_BUCKET_NAME                                     = module.logs_bucket.CONTENT_BUCKET
  LOGS_BUCKET_ARN                                      = module.logs_bucket.BUCKET_ARN
  ENVIRONMENT                                          = module.tags.ENVIRONMENT
  ATHENA_DIRECTORY_QUERY_PREFIX                        = var.ATHENA_DIRECTORY_QUERY_PREFIX_CENTRALIZED_LOGS
  ATHENA_WORKGROUP_LOGS_STATE                          = var.ATHENA_WORKGROUP_LOGS_STATE_CENTRALIZED_LOGS
  KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION         = var.KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION_CENTRALIZED_LOGS
  KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX              = var.KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX_CENTRALIZED_LOGS
  KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX = var.KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX_CENTRALIZED_LOGS
  BUFFERING_INTERVAL_IN_SECONDS                        = var.BUFFERING_INTERVAL_IN_SECONDS_CENTRALIZED_LOGS
  BUFFERING_SIZE_IN_MBS                                = var.BUFFERING_SIZE_IN_MBS_CENTRALIZED_LOGS
  GLUE_CRAWLER_SCHEDULE                                = var.GLUE_CRAWLER_SCHEDULE_CENTRALIZED_LOGS
  GLUE_DB_NAME                                         = var.GLUE_DB_NAME_CENTRALIZED_LOGS
  POLICY_STATEMENT_ACTION                              = var.POLICY_STATEMENT_ACTION_CENTRALIZED_LOGS
  TAGS                                                 = module.tags.TAGS
}

module "lambda_ecr_api_gateway" {
  source = "7clouds-terraform-modules/lambda-ecr-api-gateway/aws"
  version = "0.1.1"

  PROJECT_NAME                        = var.TAGS_MODULE.PROJECT_NAME
  ENVIRONMENT                         = var.TAGS_MODULE.ENVIRONMENT
  SECURITY_GROUP_IDS                  = [module.base_networking.SECURITY_GROUP_ID]
  SUBNET_IDS                          = module.base_networking.PRIVATE_SUBNET_ID_LIST
  API_GATEWAY_RESOURCE_PATH           = var.API_GATEWAY_RESOURCE_PATH_LAMBDA_API
  ECR_REPOSITORY_NAME                 = var.ECR_REPOSITORY_NAME_LAMBDA_API
  ECR_IMAGE_TAG                       = var.ECR_IMAGE_TAG_LAMBDA_API
  TAGS                                = module.tags.TAGS
  WARMUP_ENABLED                      = var.WARMUP_ENABLED_LAMBDA_API
  LAMBDA_WARMUP_SCHEDULE_EXPRESSION   = var.LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API
  MEMORY_SIZE                         = var.MEMORY_SIZE_LAMBDA_API
  TIMEOUT                             = var.TIMEOUT_LAMBDA_API
  ENVIRONMENT_VARIABLES               = merge({ FIREHOSE_STREAM_NAME = module.centralized_logs.KINESIS_FIREHOSE_DELIVERY_STREAM_NAME, content_bucket = module.content_management_bucket.CONTENT_BUCKET }, var.ENVIRONMENT_VARIABLES_LAMBDA_API)
  ATTACHED_POLICY_ARNS                = concat([module.cloudwatch_disable_policy.IAM_POLICY_ARN, module.content_bucket_allow_policy.IAM_POLICY_ARN], var.LAMBDA_MANAGED_POLICIES_ARN_LIST)
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
  WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST = [module.lambda_ecr_api_gateway.API_GATEWAY_STAGE_ARN]
  RULES                                 = var.RULES_WAF_STANDARD
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
