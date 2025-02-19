output "REST_API_ENDPOINT" {
  description = "API Gateway swagger endpoint URL for current stage"
  value       = module.lambda_ecr_api_gateway.REST_API_ENDPOINT
}

output "CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN" {
  description = "ARN for the warmup rule created for lambda function"
  value       = module.lambda_ecr_api_gateway.CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN
}