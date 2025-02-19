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
############################### CENTRALIZED LOGS BUCKET VARIABLES #####################################
variable "CREATE_LOGS_BUCKET" {
  type        = bool
  description = "To control if S3 bucket should be created"
}

variable "LOGS_BUCKET_NAME" {
  type        = string
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length"
}

variable "LOGS_BUCKET_FORCE_DESTROY" {
  type        = bool
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "LOGS_BUCKET_ACL" {
  type        = string
  description = "The canned ACL to apply. Conflicts with 'grant'"
}

variable "LOGS_BUCKET_BLOCK_PUBLIC_ACLS" {
  type        = bool
  description = "To define whether Amazon S3 should block public ACLs for this bucket"
}

variable "LOGS_BUCKET_BLOCK_PUBLIC_POLICY" {
  type        = bool
  description = "To define whether Amazon S3 should block public bucket policies for this bucket"
}

variable "LOGS_BUCKET_IGNORE_PUBLIC_ACLS" {
  type        = bool
  description = "To define whether Amazon S3 should ignore public ACLs for this bucket"
}

variable "LOGS_BUCKET_RESTRICT_PUBLIC_BUCKETS" {
  type        = bool
  description = "To define whether Amazon S3 should restrict public bucket policies for this bucket"
}

variable "LOGS_BUCKET_SERVER_SIDE_ENCRYPTION_CONFIGURATION" {
  type        = any
  description = "Server-side encryption configuration"
}

variable "LOGS_BUCKET_LOCALS_LIFECYCLE_RULES" {
  type        = any
  description = "List of maps containing configuration of object lifecycle management to be assigned on Locals"
}
############################### CENTRALIZED LOGS VARIABLES #####################################
variable "ATHENA_DIRECTORY_QUERY_PREFIX_CENTRALIZED_LOGS" {
  description = "Prefix for Athena's query logs"
  type        = string
}

variable "ATHENA_WORKGROUP_LOGS_STATE_CENTRALIZED_LOGS" {
  description = "For setting the Athena Workgroup's state"
  type        = string
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_DESTINATION_CENTRALIZED_LOGS" {
  description = "For setting the data destination"
  type        = string
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_SUFFIX_CENTRALIZED_LOGS" {
  description = "For setting the suffix on the extended s3 configuration"
  type        = string
}

variable "KINESIS_FIREHOSE_DELIVERY_STREAM_ERROR_OUTPUT_SUFFIX_CENTRALIZED_LOGS" {
  description = "For setting the error output prefix on the extended s3 configuration"
  type        = string
}

variable "BUFFERING_INTERVAL_IN_SECONDS_CENTRALIZED_LOGS" {
  description = "Buffer interval in seconds"
  type        = number
}

variable "BUFFERING_SIZE_IN_MBS_CENTRALIZED_LOGS" {
  description = "Buffer size in MBs"
  type        = number
}

variable "GLUE_CRAWLER_SCHEDULE_CENTRALIZED_LOGS" {
  description = "Cron Expression for Glue Crawler's schedule"
  type        = string
}

variable "GLUE_DB_NAME_CENTRALIZED_LOGS" {
  description = "Glue database name"
  type        = string
}

variable "POLICY_STATEMENT_ACTION_CENTRALIZED_LOGS" {
  description = "Block of additional actions for Kinesis Roles"
  type        = list(any)
}

############################### LOGGING LAYER VARIABLES #####################################

variable "COMPATIBLE_RUNTIMES_LOGGING_LAYER" {
  description = "List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified"
  type        = string
}

variable "LAYER_NAME_LOGGING_LAYER" {
  description = "Unique name for your Lambda Layer"
  type        = string
}

variable "DESCRIPTION_LOGGING_LAYER" {
  description = "Description of what your Lambda Layer does"
  type        = string
}

variable "FILENAME_LOGGING_LAYER" {
  type        = string
  description = "Path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used"
}

############################### LAMBDA ECR API GATEWAY VARIABLES #################################
variable "API_GATEWAY_RESOURCE_PATH_LAMBDA_API" {
  type        = string
  description = "API Gateway Resource Path"
}

variable "ECR_REPOSITORY_NAME_LAMBDA_API" {
  description = "Name of the ECR Repository"
  type        = string
}

variable "ECR_IMAGE_TAG_LAMBDA_API" {
  description = "Tag associated with this image"
  type        = string
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
############################### WAF IP BLOCK VARIABLES #################################
variable "WAF_IP_ADDRESS_VERSION_WAF_IP_BLOCK" {
  type        = string
  description = "Valid values are IPV4 or IPV6"
}

variable "WAF_ALLOWED_IP_ADDRESS_LIST_WAF_IP_BLOCK" {
  type        = list(string)
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR / with /32) notation."
  default     = []
}

variable "WAF_IP_SET_SCOPE_WAF_IP_BLOCK" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
}

variable "WAF_IP_SET_ALLOW_WAF_IP_BLOCK" {
  type        = string
  description = "Name for AWS Managed IP Set Allowing Rules"
}

variable "WAF_SCOPE_CLOUDWATCH_METRICS_WAF_IP_BLOCK" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_SCOPE_SAMPLED_REQUESTS_WAF_IP_BLOCK" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "WAF_IP_SET_ALLOW_CLOUDWATCH_METRICS_WAF_IP_BLOCK" {
  type        = bool
  description = "Whether the associated resource sends metrics to CloudWatch"
}

variable "WAF_IP_SET_ALLOW_SAMPLED_REQUESTS_WAF_IP_BLOCK" {
  type        = bool
  description = "Whether AWS WAF should store a sampling of the web requests that match the rules"
}

variable "RULES_WAF_IP_BLOCK" {
  type        = list(any)
  description = "Rule blocks used to identify the web requests that you want to allow, block, or count"
  default     = []
}

############################### TAGS VARIABLES #################################
variable "TAGS_MODULE" {
  description = "Map of Tags"
  type        = map(any)
}