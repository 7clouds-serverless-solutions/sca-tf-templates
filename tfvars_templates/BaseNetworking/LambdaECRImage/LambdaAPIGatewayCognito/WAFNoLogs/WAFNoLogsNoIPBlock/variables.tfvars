POLICY_ACTION_CLOUDWATCH_DISABLE                  = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
POLICY_EFFECT_CLOUDWATCH_DISABLE                  = "Deny"
POLICY_RESOURCE_CLOUDWATCH_DISABLE                = ["arn:aws:logs:*:*:*"]
POLICY_NAME_CLOUDWATCH_DISABLE                    = "cloudwatch-disable"
POLICY_DESCRIPTION_CLOUDWATCH_DISABLE             = "A policy to disable cloudwatch creation of log groups and log event creation by the Lambda Function"
POLICY_ACTION_CONTENT_BUCKET_ALLOW                = ["s3:*"]
POLICY_EFFECT_CONTENT_BUCKET_ALLOW                = "Allow"
POLICY_NAME_CONTENT_BUCKET_ALLOW                  = "content-bucket-access"
POLICY_DESCRIPTION_CONTENT_BUCKET_ALLOW           = "Policy to allow access of the content bucket to the Lambda Function"
CREATE_CONTENT_MANAGEMENT_BUCKET                  = true
CONTENT_MANAGEMENT_BUCKET_NAME                    = "content-management-bucket"
CONTENT_MANAGEMENT_BUCKET_FORCE_DESTROY           = true
CONTENT_MANAGEMENT_BUCKET_ACL                     = "private"
CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_ACLS       = true
CONTENT_MANAGEMENT_BUCKET_BLOCK_PUBLIC_POLICY     = true
CONTENT_MANAGEMENT_BUCKET_IGNORE_PUBLIC_ACLS      = true
CONTENT_MANAGEMENT_BUCKET_RESTRICT_PUBLIC_BUCKETS = true
CONTENT_MANAGEMENT_BUCKET_SERVER_SIDE_ENCRYPTION_CONFIGURATION = {
  rule = {
    apply_server_side_encryption_by_default = {
      sse_algorithm = "AES256"
    }
  }
}
CONTENT_MANAGEMENT_BUCKET_VERSIONING = {
  versioning = true
  status     = "Enabled"
}
API_GATEWAY_RESOURCE_PATH_LAMBDA_API           = "{proxy+}"
ECR_REPOSITORY_NAME_LAMBDA_API                 = "testproject/testlambdaecr"
ECR_IMAGE_TAG_LAMBDA_API                       = "latest"
WARMUP_ENABLED_LAMBDA_API                                             = false
LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API   = "rate(5 minutes)"
MEMORY_SIZE_LAMBDA_API                         = 128
TIMEOUT_LAMBDA_API                             = 60
ENVIRONMENT_VARIABLES_LAMBDA_API               = {}
API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API    = "NONE"
API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API      = "ANY"
API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API = "POST"
API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API  = "AWS_PROXY"
LAMBDA_MANAGED_POLICIES_ARN_LIST               = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite", "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"]
WAF_WEB_ACL_SCOPE_STANDARD                     = "REGIONAL"
WAF_SCOPE_CLOUDWATCH_METRICS_STANDARD          = false
WAF_SCOPE_SAMPLED_REQUESTS_STANDARD            = true
RULES_WAF_STANDARD = [
  {
    name                                     = "AWSManagedRulesAmazonIpReputationList"
    managed_rule_group_statement_name        = "AWSManagedRulesAmazonIpReputationList"
    managed_rule_group_statement_vendor_name = "AWS"
    metric_name                              = "AWSManagedRulesAmazonIpReputationList"
    priority                                 = 1
  },
  {
    name                                     = "AWSManagedRulesSQLiRuleSet"
    managed_rule_group_statement_name        = "AWSManagedRulesSQLiRuleSet"
    managed_rule_group_statement_vendor_name = "AWS"
    metric_name                              = "AWSManagedRulesSQLiRuleSet"
    priority                                 = 2
  },
  {
    name                                     = "AWSManagedRulesAnonymousIpList"
    managed_rule_group_statement_name        = "AWSManagedRulesAnonymousIpList"
    managed_rule_group_statement_vendor_name = "AWS"
    metric_name                              = "AWSManagedRulesAnonymousIpList"
    priority                                 = 3
  }
]
AZ_COUNT_BASE_NETWORKING                     = 2
COGNITO_USER_POOL_NAME                       = "user-pool-example"
COGNITO_USER_POOL_VERIFICATION_MESSAGE       = "Your verification code is {####}."
COGNITO_USER_POOL_EMAIL_VERIFICATION_SUBJECT = "Your verification code"
COGNITO_USER_POOL_ADMIN_CREATE_USER_CONFIG = [{
  allow_admin_create_user_only = true
  email_message                = "Your username is {username} and temporary password is {####}."
  email_subject                = "Your verification code"
  sms_message                  = "Your username is {username} and temporary password is {####}."
}]

COGNITO_USER_POOL_PASSWORD_POLICY = [{
  minimum_length                   = 8
  require_lowercase                = false
  require_numbers                  = false
  require_symbols                  = false
  require_uppercase                = false
  temporary_password_validity_days = 1
}]

COGNITO_CLIENT_NAME                          = "cognito-client-example"
COGNITO_CLIENT_SUPPORTED_IDENTITY_PROVIDERS  = ["COGNITO"]
COGNITO_CLIENT_ALLOWED_OAUTH_FLOWS           = ["implicit"]
COGNITO_CLIENT_ALLOWED_OAUTH_SCOPES          = ["openid", "profile"]
COGNITO_CLIENT_CALLBACK_URLS                 = ["https://localhost:5000/callback"]
COGNITO_CLIENT_LOGOUT_URLS                   = ["https://localhost:5000/sign-out"]
COGNITO_CLIENT_GENERATE_SECRET               = false
COGNITO_CLIENT_EXPLICIT_AUTH_FLOWS           = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
COGNITO_ALLOWED_OAUTH_FLOWS_USER_POOL_CLIENT = true

COGNITO_DOMAIN = "example-domain-testing"

COGNITO_USER_GROUP_ATTRIBUTES_LIST = [
  {
    name        = "admin"
    description = null
    precedence  = 0
    role_arn    = null
  },
  {
    name        = "write"
    description = null
    precedence  = 1
    role_arn    = null
  },
  {
    name        = "read"
    description = null
    precedence  = 2
    role_arn    = null
  },
  {
    name        = "delete"
    description = null
    precedence  = 3
    role_arn    = null
  },
]

COGNITO_USERNAME                    = "your_user_here"
COGNITO_USER_PASSWORD               = "your_password_here"
COGNITO_GROUPS_TO_ASSOCIATE_USER_TO = ["admin", "write", "read", "delete"]

TAGS_MODULE = {
  AWS_REGION      = "***"
  PROJECT_NAME    = "ExampleProject"
  ENVIRONMENT     = "DEV"
  COMPANY         = "CompanyName"
  OWNER           = "ProjectOwner"
  PROJECT_TYPE    = "Serverless"
  PROJECT_VERSION = "v0.1.0"
  LOB             = "Large Accounts"
  APP_ID          = "TASK-1005"
}
