############################### ATTACHABLE NETWORK VARIABLES #################################
variable "SECURITY_GROUP_IDS" {
  description = "Existing Security Group(s) for attaching to this project"
  type        = list(string)
  default     = []
}

variable "SUBNET_IDS" {
  description = "Existing Subnet(s) for attaching to this project"
  type        = list(string)
  default     = []
}

############################### DEPENDENCIES LAYER VARIABLES #################################
variable "COMPATIBLE_RUNTIMES_DEPENDENCIES_LAYER" {
  description = "List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified"
  type        = string
}

variable "LAYER_NAME_DEPENDENCIES_LAYER" {
  description = "Unique name for your Lambda Layer"
  type        = string
}

variable "DESCRIPTION_DEPENDENCIES_LAYER" {
  description = "Description of what your Lambda Layer does"
  type        = string
}

variable "FILENAME_DEPENDENCIES_LAYER" {
  description = "Path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used"
  type        = string
}

############################### CLOUDWATCH DISABLE POLICY VARIABLES #################################
variable "POLICY_ACTION_CLOUDWATCH_DISABLE" {
  description = "Action executed in the policy"
  type        = list(any)
}

variable "POLICY_EFFECT_CLOUDWATCH_DISABLE" {
  description = "Either allow or deny for the actions"
  type        = string
}

variable "POLICY_RESOURCE_CLOUDWATCH_DISABLE" {
  description = "Resource to be allowed or denied actions"
  type        = list(any)
}

variable "POLICY_NAME_CLOUDWATCH_DISABLE" {
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  type        = string
}

variable "POLICY_DESCRIPTION_CLOUDWATCH_DISABLE" {
  description = "Description for the policy"
  type        = string
}

############################### CONTENT BUCKET ALLOW POLICY VARIABLES #################################
variable "POLICY_ACTION_CONTENT_BUCKET_ALLOW" {
  description = "Action executed in the policy"
  type        = list(any)
}

variable "POLICY_EFFECT_CONTENT_BUCKET_ALLOW" {
  description = "Either allow or deny for the actions"
  type        = string
}

variable "POLICY_NAME_CONTENT_BUCKET_ALLOW" {
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  type        = string
}

variable "POLICY_DESCRIPTION_CONTENT_BUCKET_ALLOW" {
  description = "Description for the policy"
  type        = string
}

############################### CONTENT BUCKET VARIABLES #####################################
variable "CREATE_CONTENT_MANAGEMENT_BUCKET" {
  type        = bool
  description = "To control if S3 bucket should be created"
}

variable "CONTENT_MANAGEMENT_BUCKET_NAME" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
  type        = string
}

variable "CONTENT_MANAGEMENT_BUCKET_FORCE_DESTROY" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  type        = bool
}

variable "CONTENT_MANAGEMENT_BUCKET_ACL" {
  description = "The canned ACL to apply. Conflicts with 'grant'"
  type        = string
}

variable "CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_ACLS" {
  description = "To define whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
}

variable "CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_POLICY" {
  description = "To define whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
}

variable "CONTENT_MANAGEMENT_BUCKET_IGNORE_PUBLIC_ACLS" {
  description = "To define whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
}

variable "CONTENT_MANAGEMENT_BUCKET_RESTRICT_PUBLIC_BUCKETS" {
  description = "To define whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
}

variable "CONTENT_MANAGEMENT_BUCKET_SERVER_SIDE_ENCRYPTION_CONFIGURATION" {
  description = "Server-side encryption configuration"
  type        = any
}

variable "CONTENT_MANAGEMENT_BUCKET_VERSIONING" {
  description = "Versioning configuration map"
  type        = map(string)
}

############################### LAMBDA API GATEWAY VARIABLES #################################
variable "API_GATEWAY_RESOURCE_PATH_LAMBDA_API" {
  type        = string
  description = "API Gateway Resource Path"
}

variable "COMPATIBLE_RUNTIMES_LAMBDA_API" {
  type        = string
  description = "Lambda Function Compatible Runtimes"
}

variable "LAMBDA_CODE_ZIP_FILE_LAMBDA_API" {
  type        = string
  description = "Lambda Function Zip File"
}

variable "WARMUP_ENABLED_LAMBDA_API" {
  type        = bool
  description = "Boolean to define whether this lambda function will have WarmUp Event triggered By CloudWatch"
}

variable "LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API" {
  type        = string
  description = "Schedule Expression for Lambda Warm Up Events Rule"
}

variable "MEMORY_SIZE_LAMBDA_API" {
  type        = number
  description = "Lambda Function Memory Size"
}

variable "TIMEOUT_LAMBDA_API" {
  type        = number
  description = "Timeout for lambda function"
}

variable "HANDLER_LAMBDA_API" {
  type        = string
  description = "Lambda Function Handler"
}

variable "ENVIRONMENT_VARIABLES_LAMBDA_API" {
  type        = map(any)
  description = "Environment Variables for Lambda Function"
  default     = {}
}

variable "API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API" {
  type        = string
  description = "API Gateway Method Authorization"
}

variable "API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API" {
  type        = string
  description = "HTTP Method"
}

variable "API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API" {
  type        = string
  description = "Integration HTTP method specifying how API Gateway will interact with the back end. Lambda function can only be invoked via POST."
}

variable "API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API" {
  type        = string
  description = "Integration input's type. 'AWS_PROXY' was set for Lambda Proxy Integration"
}

variable "LAMBDA_MANAGED_POLICIES_ARN_LIST" {
  type        = list(string)
  description = "Variable for concatenating additional managed policies ARNs to Lambda Permissions"
}

############################### WAF STANDARD VARIABLES #################################
variable "WAF_WEB_ACL_SCOPE_STANDARD" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

variable "WAF_SCOPE_CLOUDWATCH_METRICS_STANDARD" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_SCOPE_SAMPLED_REQUESTS_STANDARD" {
  type        = string
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "RULES_WAF_STANDARD" {
  type        = list(any)
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
}

######################### ELASTICACHE REDIS VARIABLES ##########################

variable "ELASTICACHE_SUBNET_GROUP_NAME" {
  description = "Name for the cache subnet group. ElastiCache converts this name to lowercase."
  type        = string
}

variable "ELASTICACHE_CLUSTER_ENGINE" {
  description = "Required if replication_group_id is not specified. Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis"
  type        = string
}

variable "ELASTICACHE_CLUSTER_NODE_TYPE" {
  description = "Required unless replication_group_id is provided. The instance class used.  For Memcached, changing this value will re-create the resource"
  type        = string
}

variable "ELASTICACHE_CLUSTER_NUM_CACHE_NODES" {
  description = "Required unless replication_group_id is provided. The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40. If this number is reduced on subsequent runs, the highest numbered nodes will be removed"
  type        = number
}

variable "ELASTICACHE_CLUSTER_PORT_NUMBER" {
  description = "The port number on which each of the cache nodes will accept connections. For Memcached the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id. Changing this value will re-create the resource"
  type        = number
}

######################### COGNITO USER POOL VARIABLES ##########################

variable "COGNITO_USER_POOL_NAME" {
  description = "Name for the Cognito's User Pool"
  type        = string
}

variable "COGNITO_USER_POOL_VERIFICATION_MESSAGE" {
  type        = string
  description = "String representing the email verification message. Conflicts with verification_message_template configuration block email_message argument"
}

variable "COGNITO_USER_POOL_EMAIL_VERIFICATION_SUBJECT" {
  description = "String representing the email verification subject. Conflicts with verification_message_template configuration block email_subject argument"
  type        = string
}

variable "COGNITO_USER_POOL_ADMIN_CREATE_USER_CONFIG" {
  description = "A map for admin_create_user_config block"
  type = set(object({
    allow_admin_create_user_only = bool
    email_message                = string
    email_subject                = string
    sms_message                  = string
    }
    )
  )
}

variable "COGNITO_USER_POOL_PASSWORD_POLICY" {
  description = "Key / Value Pairs for Cognito's User Pool Dynamic Password Policy"
  type = set(object({
    minimum_length                   = number
    require_lowercase                = bool
    require_uppercase                = bool
    require_numbers                  = bool
    require_symbols                  = bool
    temporary_password_validity_days = number
    }
    )
  )
}
########################### COGNITO CLIENT VARIABLES ###########################

variable "COGNITO_CLIENT_NAME" {
  description = "Name of the application client"
  type        = string
}

variable "COGNITO_CLIENT_SUPPORTED_IDENTITY_PROVIDERS" {
  description = "List of provider names for the identity providers that are supported on this client. Uses the provider_name attribute of aws_cognito_identity_provider resource(s), or the equivalent string(s)"
  type        = set(string)
}

variable "COGNITO_CLIENT_ALLOWED_OAUTH_FLOWS" {
  description = "List of allowed OAuth flows (code, implicit, client_credentials)"
  type        = set(string)
}

variable "COGNITO_CLIENT_ALLOWED_OAUTH_SCOPES" {
  description = "List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin)"
  type        = set(string)
}

variable "COGNITO_CLIENT_CALLBACK_URLS" {
  description = "List of allowed callback URLs for the identity providers"
  type        = set(string)
}

variable "COGNITO_CLIENT_LOGOUT_URLS" {
  description = "List of allowed logout URLs for the identity providers"
  type        = set(string)
}

variable "COGNITO_CLIENT_GENERATE_SECRET" {
  description = "Should an application secret be generated"
  type        = bool
}

variable "COGNITO_CLIENT_EXPLICIT_AUTH_FLOWS" {
  description = "List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH)"
  type        = set(string)
}

variable "COGNITO_ALLOWED_OAUTH_FLOWS_USER_POOL_CLIENT" {
  description = "Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools"
  type        = bool
  default     = null
}

########################### COGNITO DOMAIN VARIABLE ############################

variable "COGNITO_DOMAIN" {
  description = "To use if your domain is NOT custom. It will conflict with var.AMAZON_COGNITO_CUSTOM_DOMAIN"
  type        = string
}

######################### COGNITO USER GROUP VARIABLE ##########################

variable "COGNITO_USER_GROUP_ATTRIBUTES_LIST" {
  description = "Attributes list for each cognito user group resource"
  type        = list(any)
}

################# COGNITO USER AND GROUP ASSOCIATION VARIABLES #################

variable "COGNITO_USERNAME" {
  description = "The username for the user. Must be unique within the user pool. Must be a UTF-8 string between 1 and 128 characters. After the user is created, the username cannot be changed"
  type        = string
}

variable "COGNITO_USER_PASSWORD" {
  description = "The user's permanent password. This password must conform to the password policy specified by user pool the user belongs to. The welcome message always contains only temporary_password value. You can suppress sending the welcome message with the message_action argument. Amazon Cognito does not store the password value. Conflicts with temporary_password"
  type        = string
}

variable "COGNITO_GROUPS_TO_ASSOCIATE_USER_TO" {
  description = "Group list for user association"
  type        = list(string)
}

############################### TAGS VARIABLES #################################
variable "TAGS_MODULE" {
  description = "Map of Tags"
  type        = map(any)
}