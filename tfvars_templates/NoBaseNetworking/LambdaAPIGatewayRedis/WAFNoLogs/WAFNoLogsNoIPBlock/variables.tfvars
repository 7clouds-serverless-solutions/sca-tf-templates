COMPATIBLE_RUNTIMES_DEPENDENCIES_LAYER            = "python3.8"
LAYER_NAME_DEPENDENCIES_LAYER                     = "TestProjectDependenciesLayer"
DESCRIPTION_DEPENDENCIES_LAYER                    = "Python Flask Dependencies for a Simple API"
FILENAME_DEPENDENCIES_LAYER                       = "YOUR_PATH_HERE"
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
COMPATIBLE_RUNTIMES_LAMBDA_API                 = "python3.8"
LAMBDA_CODE_ZIP_FILE_LAMBDA_API                = "YOUR_PATH_HERE"
WARMUP_ENABLED_LAMBDA_API                      = true
LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API   = "rate(5 minutes)"
MEMORY_SIZE_LAMBDA_API                         = 128
TIMEOUT_LAMBDA_API                             = 60
HANDLER_LAMBDA_API                             = "app.lambda_handler"
ENVIRONMENT_VARIABLES_LAMBDA_API               = {}
API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API    = "NONE"
API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API      = "ANY"
API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API = "POST"
API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API  = "AWS_PROXY"
LAMBDA_MANAGED_POLICIES_ARN_LIST               = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
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
CREATE_CUSTOM_PUBLIC_SUBNET_ACL_BASE_NETWORKING  = true
CREATE_CUSTOM_PRIVATE_SUBNET_ACL_BASE_NETWORKING = true
PUBLIC_SUBNET_ACL_RULE_INGRESS_LIST_BASE_NETWORKING = [
  {
    rule_number = 100
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },

  {
    rule_number = 200
    egress      = false
    protocol    = "tcp"
    rule_action = "deny"
    cidr_block  = "172.0.0.0/0"
    from_port   = 80
    to_port     = 5000
  }
]
PUBLIC_SUBNET_ACL_RULE_EGRESS_LIST_BASE_NETWORKING = [
  {
    rule_number = 100
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },

  {
    rule_number = 200
    egress      = true
    protocol    = "tcp"
    rule_action = "deny"
    cidr_block  = "172.0.0.0/0"
    from_port   = 80
    to_port     = 5000
  }
]
PRIVATE_SUBNET_ACL_RULE_INGRESS_LIST_BASE_NETWORKING = [
  {
    rule_number = 100
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },

  {
    rule_number = 200
    egress      = false
    protocol    = "tcp"
    rule_action = "deny"
    cidr_block  = "172.0.0.0/0"
    from_port   = 80
    to_port     = 5000
  }
]
PRIVATE_SUBNET_ACL_RULE_EGRESS_LIST_BASE_NETWORKING = [
  {
    rule_number = 100
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    cidr_block  = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
  },

  {
    rule_number = 200
    egress      = true
    protocol    = "tcp"
    rule_action = "deny"
    cidr_block  = "172.0.0.0/0"
    from_port   = 80
    to_port     = 5000
  }
]

ELASTICACHE_SUBNET_GROUP_NAME       = "elasticache-subnet-group-example"
ELASTICACHE_CLUSTER_ENGINE          = "redis"
ELASTICACHE_CLUSTER_NODE_TYPE       = "cache.t2.micro"
ELASTICACHE_CLUSTER_NUM_CACHE_NODES = 1
ELASTICACHE_CLUSTER_PORT_NUMBER     = 6379

TAGS_MODULE = {
  AWS_REGION      = "us-east-1"
  PROJECT_NAME    = "ExampleProject"
  ENVIRONMENT     = "DEV"
  COMPANY         = "CompanyName"
  OWNER           = "ProjectOwner"
  PROJECT_TYPE    = "Serverless"
  PROJECT_VERSION = "v0.1.0"
  LOB             = "Large Accounts"
}
