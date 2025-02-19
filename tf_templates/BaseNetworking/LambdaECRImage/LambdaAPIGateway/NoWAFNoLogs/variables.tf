############################### BASE NETWORKING VARIABLES #################################
variable "AZ_COUNT_BASE_NETWORKING" {
  type        = number
  description = "Fixed number of AZs to create resources"
}

variable "VPC_CIDR_BASE_NETWORKING" {
  description = "The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length"
  type        = string
  default     = "10.192.0.0/16"
}

variable "PUBLIC_SUBNETS_CIDR_BLOCK_LIST_BASE_NETWORKING" {
  type        = list(string)
  default     = []
  description = "Explicit Public Subnet CIDR Block List to overrule creation pattern of Public Subnets. If filled out, this attribute needs to have as many items as the amount of AZs in the selected region if var \"AZ_COUNT\" is not set, or with the same amount of var \"AZ_COUNT\" otherwise"
}

variable "PRIVATE_SUBNETS_CIDR_BLOCK_LIST_BASE_NETWORKING" {
  type        = list(string)
  default     = []
  description = "Explicit Private Subnet CIDR Block List to overrule creation pattern of Public Subnets. If filled out, this attribute needs to have as many items as the amount of AZs in the selected region if var \"AZ_COUNT\" is not set, or with the same amount of var \"AZ_COUNT\" otherwise"
}

variable "PUBLIC_ROUTE_TABLE_CIDR_BLOCK_BASE_NETWORKING" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "PRIVATE_ROUTE_TABLES_CIDR_BLOCK_BASE_NETWORKING" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
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
############################### TAGS VARIABLES #################################
variable "TAGS_MODULE" {
  description = "Map of Tags"
  type        = map(any)
}