output "REST_API_ENDPOINT" {
  description = "API Gateway swagger endpoint URL for current stage"
  value       = module.lambda_ecr_api_gateway.REST_API_ENDPOINT
}

output "CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN" {
  description = "ARN for the warmup rule created for lambda function"
  value       = module.lambda_ecr_api_gateway.CLOUDWATCH_LAMBDA_WARMUP_EVENTS_RULE_ARN
}

output "COGNITO_DOMAIN_AUTH_URL" {
  description = "Auth URL for testing Cognito on Postman"
  value       = module.cognito_domain.AMAZON_COGNITO_DOMAIN_AUTH_URL
}

output "COGNITO_CLIENT_ID" {
  description = "Client's ID"
  value       = module.cognito_client.CLIENT_ID
}

output "COGNITO_CLIENT_CALLBACK_URLS" {
  description = "Client's callback urls"
  value       = module.cognito_client.CLIENT_CALLBACK_URLS
}

output "COGNITO_CLIENT_LOGOUT_URLS" {
  description = "Client's logout urls"
  value       = module.cognito_client.CLIENT_LOGOUT_URL
}