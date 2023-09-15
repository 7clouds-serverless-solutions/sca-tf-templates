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

module "dependencies_layer" {
  source  = "7clouds-terraform-modules/lambda-layer/aws"
  version = "0.1.0"

  COMPATIBLE_RUNTIMES = var.COMPATIBLE_RUNTIMES_DEPENDENCIES_LAYER
  LAYER_NAME          = var.LAYER_NAME_DEPENDENCIES_LAYER
  DESCRIPTION         = var.DESCRIPTION_DEPENDENCIES_LAYER
  FILENAME            = var.FILENAME_DEPENDENCIES_LAYER
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
  version = "0.1.1"

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
  version    = "0.1.1"
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

module "lambda_api_gateway" {
  source  = "7clouds-terraform-modules/lambda-api-gateway/aws"
  version = "0.1.4"

  PROJECT_NAME                        = var.TAGS_MODULE.PROJECT_NAME
  ENVIRONMENT                         = var.TAGS_MODULE.ENVIRONMENT
  SECURITY_GROUP_IDS                  = [module.base_networking.SECURITY_GROUP_ID]
  SUBNET_IDS                          = module.base_networking.PRIVATE_SUBNET_ID_LIST
  API_GATEWAY_RESOURCE_PATH           = var.API_GATEWAY_RESOURCE_PATH_LAMBDA_API
  COMPATIBLE_RUNTIMES                 = var.COMPATIBLE_RUNTIMES_LAMBDA_API
  LAMBDA_CODE_ZIP_FILE                = var.LAMBDA_CODE_ZIP_FILE_LAMBDA_API
  TAGS                                = module.tags.TAGS
  LAYER_ARN_LIST                      = [module.dependencies_layer.LAYER_ARN, module.logging_layers.LAYER_ARN]
  WARMUP_ENABLED                      = var.WARMUP_ENABLED_LAMBDA_API
  LAMBDA_WARMUP_SCHEDULE_EXPRESSION   = var.LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API
  MEMORY_SIZE                         = var.MEMORY_SIZE_LAMBDA_API
  TIMEOUT                             = var.TIMEOUT_LAMBDA_API
  HANDLER                             = var.HANDLER_LAMBDA_API
  ENVIRONMENT_VARIABLES               = merge({ FIREHOSE_STREAM_NAME = module.centralized_logs.KINESIS_FIREHOSE_DELIVERY_STREAM_NAME, content_bucket = module.content_management_bucket.CONTENT_BUCKET, user_pool_id = module.cognito_user_pool.USER_POOL_ID, app_client_id = module.cognito_client.CLIENT_ID, redis_host = module.elasticache_redis.ELASTICACHE_NODE_ADDRESS[0], redis_port = module.elasticache_redis.ELASTICACHE_NODE_PORT_NUMBER[0] }, var.ENVIRONMENT_VARIABLES_LAMBDA_API)
  MANAGED_POLICY_ARNS                 = concat([module.cloudwatch_disable_policy.IAM_POLICY_ARN, module.content_bucket_allow_policy.IAM_POLICY_ARN], var.LAMBDA_MANAGED_POLICIES_ARN_LIST)
  API_GATEWAY_METHOD_AUTHORIZATION    = var.API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API
  API_GATEWAY_METHOD_HTTP_METHOD      = var.API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API
  API_GATEWAY_INTEGRATION_HTTP_METHOD = var.API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API
  API_GATEWAY_INTEGRATION_INPUT_TYPE  = var.API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API
}

module "waf_ip_block" {
  source  = "7clouds-terraform-modules/waf-ip-block/aws"
  version = "0.1.0"

  PROJECT_NAME                          = var.TAGS_MODULE.PROJECT_NAME
  WAF_IP_ADDRESS_VERSION                = var.WAF_IP_ADDRESS_VERSION_WAF_IP_BLOCK
  WAF_ALLOWED_IP_ADDRESS_LIST           = var.WAF_ALLOWED_IP_ADDRESS_LIST_WAF_IP_BLOCK
  WAF_IP_SET_SCOPE                      = var.WAF_IP_SET_SCOPE_WAF_IP_BLOCK
  WAF_IP_SET_ALLOW                      = var.WAF_IP_SET_ALLOW_WAF_IP_BLOCK
  WAF_SCOPE_CLOUDWATCH_METRICS          = var.WAF_SCOPE_CLOUDWATCH_METRICS_WAF_IP_BLOCK
  WAF_SCOPE_SAMPLED_REQUESTS            = var.WAF_SCOPE_SAMPLED_REQUESTS_WAF_IP_BLOCK
  WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS   = var.WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS_WAF_IP_BLOCK
  WAF_IP_SET_ALLOW_SAMPLED_REQUESTS     = var.WAF_IP_SET_ALLOW_SAMPLED_REQUESTS_WAF_IP_BLOCK
  WEB_ACL_ASSOCIATION_RESOURCE_ARN_LIST = [module.lambda_api_gateway.API_GATEWAY_STAGE_ARN]
  RULES                                 = var.RULES_WAF_IP_BLOCK
}

module "elasticache_redis" {
  source  = "7clouds-terraform-modules/elasticache/aws"
  version = "0.1.0"

  PROJECT_NAME          = var.TAGS_MODULE.PROJECT_NAME
  SUBNET_GROUP_NAME     = var.ELASTICACHE_SUBNET_GROUP_NAME
  SUBNET_GROUP_IDS_LIST = module.base_networking.PRIVATE_SUBNET_ID_LIST

  CLUSTER_ID                  = lower("${var.TAGS_MODULE.PROJECT_NAME}-redis")
  CLUSTER_ENGINE              = var.ELASTICACHE_CLUSTER_ENGINE
  CLUSTER_NODE_TYPE           = var.ELASTICACHE_CLUSTER_NODE_TYPE
  CLUSTER_NUM_CACHE_NODES     = var.ELASTICACHE_CLUSTER_NUM_CACHE_NODES
  CLUSTER_PORT_NUMBER         = var.ELASTICACHE_CLUSTER_PORT_NUMBER
  CLUSTER_SECURITY_GROUPS_IDS = [module.base_networking.SECURITY_GROUP_ID]
  TAGS                        = module.tags.TAGS
}

module "cognito_user_pool" {
  source  = "7clouds-terraform-modules/cognito-user-pool/aws"
  version = "0.1.0"

  USER_POOL_NAME             = var.COGNITO_USER_POOL_NAME
  PROJECT_NAME               = var.TAGS_MODULE.PROJECT_NAME
  EMAIL_VERIFICATION_MESSAGE = var.COGNITO_USER_POOL_VERIFICATION_MESSAGE
  EMAIL_VERIFICATION_SUBJECT = var.COGNITO_USER_POOL_EMAIL_VERIFICATION_SUBJECT
  ADMIN_CREATE_USER_CONFIG   = var.COGNITO_USER_POOL_ADMIN_CREATE_USER_CONFIG
  USER_POOL_PASSWORD_POLICY  = var.COGNITO_USER_POOL_PASSWORD_POLICY
  TAGS                       = module.tags.TAGS
}

module "cognito_client" {
  source  = "7clouds-terraform-modules/cognito-client/aws"
  version = "0.1.0"

  CLIENT_NAME                          = var.COGNITO_CLIENT_NAME
  USER_POOL_ID                         = module.cognito_user_pool.USER_POOL_ID
  SUPPORTED_IDENTITY_PROVIDERS         = var.COGNITO_CLIENT_SUPPORTED_IDENTITY_PROVIDERS
  ALLOWED_OAUTH_FLOWS                  = var.COGNITO_CLIENT_ALLOWED_OAUTH_FLOWS
  ALLOWED_OAUTH_SCOPES                 = var.COGNITO_CLIENT_ALLOWED_OAUTH_SCOPES
  CALLBACK_URLS                        = var.COGNITO_CLIENT_CALLBACK_URLS
  LOGOUT_URLS                          = var.COGNITO_CLIENT_LOGOUT_URLS
  GENERATE_SECRET                      = var.COGNITO_CLIENT_GENERATE_SECRET
  EXPLICIT_AUTH_FLOWS                  = var.COGNITO_CLIENT_EXPLICIT_AUTH_FLOWS
  ALLOWED_OAUTH_FLOWS_USER_POOL_CLIENT = var.COGNITO_ALLOWED_OAUTH_FLOWS_USER_POOL_CLIENT
}

module "cognito_domain" {
  source  = "7clouds-terraform-modules/cognito-domain/aws"
  version = "0.1.0"

  USER_POOL_ID          = module.cognito_user_pool.USER_POOL_ID
  AMAZON_COGNITO_DOMAIN = var.COGNITO_DOMAIN
}

module "cognito_user_groups" {
  source = "7clouds-terraform-modules/cognito-user-group/aws"

  USER_POOL_ID               = module.cognito_user_pool.USER_POOL_ID
  USER_GROUP_ATTRIBUTES_LIST = var.COGNITO_USER_GROUP_ATTRIBUTES_LIST
}

module "cognito_user_and_group_association" {
  source     = "7clouds-terraform-modules/cognito-user-and-group-association/aws"
  version    = "0.1.0"
  depends_on = [module.cognito_user_groups]

  USER_POOL_ID             = module.cognito_user_pool.USER_POOL_ID
  USER_NAME                = var.COGNITO_USERNAME
  USER_PASSWORD            = var.COGNITO_USER_PASSWORD
  GROUP_LIST               = var.COGNITO_GROUPS_TO_ASSOCIATE_USER_TO
  USER_ATTRIBUTES          = var.COGNITO_USER_ATTRIBUTES
  DESIRED_DELIVERY_MEDIUMS = var.COGNITO_USER_DESIRED_DELIVERY_MEDIUMS
}

module "tags" {
  source  = "7clouds-terraform-modules/tags/aws"
  version = "0.1.0"

  AWS_REGION      = var.TAGS_MODULE.AWS_REGION
  PROJECT_NAME    = var.TAGS_MODULE.PROJECT_NAME
  ENVIRONMENT     = var.TAGS_MODULE.ENVIRONMENT
  COMPANY         = var.TAGS_MODULE.COMPANY
  OWNER           = var.TAGS_MODULE.OWNER
  PROJECT_TYPE    = var.TAGS_MODULE.PROJECT_TYPE
  PROJECT_VERSION = var.TAGS_MODULE.PROJECT_VERSION
  LOB             = var.TAGS_MODULE.LOB
}
