COMPATIBLE_RUNTIMES_DEPENDENCIES_LAYER            = "python3.11"
LAYER_NAME_DEPENDENCIES_LAYER                     = "TestProjectDependenciesLayer"
DESCRIPTION_DEPENDENCIES_LAYER                    = "Python Flask Dependencies for a Simple API"
FILENAME_DEPENDENCIES_LAYER                       = "YOUR_PATH_HERE"
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
COMPATIBLE_RUNTIMES_LAMBDA_API                 = "python3.11"
LAMBDA_CODE_ZIP_FILE_LAMBDA_API                = "YOUR_PATH_HERE"
WARMUP_ENABLED_LAMBDA_API                      = true
LAMBDA_WARMUP_SCHEDULE_EXPRESSION_LAMBDA_API   = "rate(5 minutes)"
MEMORY_SIZE_LAMBDA_API                         = 128
TIMEOUT_LAMBDA_API                             = 60
HANDLER_LAMBDA_API                             = "app.lambda_handler"
ENVIRONMENT_VARIABLES_LAMBDA_API               = { foo = "bar" }
API_GATEWAY_METHOD_AUTHORIZATION_LAMBDA_API    = "NONE"
API_GATEWAY_METHOD_HTTP_METHOD_LAMBDA_API      = "ANY"
API_GATEWAY_INTEGRATION_HTTP_METHOD_LAMBDA_API = "POST"
API_GATEWAY_INTEGRATION_INPUT_TYPE_LAMBDA_API  = "AWS_PROXY"
LAMBDA_MANAGED_POLICIES_ARN_LIST               = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
AZ_COUNT_BASE_NETWORKING                       = 2
ELASTICACHE_SUBNET_GROUP_NAME                  = "elasticache-subnet-group-example"
ELASTICACHE_CLUSTER_ENGINE                     = "redis"
ELASTICACHE_CLUSTER_NODE_TYPE                  = "cache.t2.micro"
ELASTICACHE_CLUSTER_NUM_CACHE_NODES            = 1
ELASTICACHE_CLUSTER_PORT_NUMBER                = 6379
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