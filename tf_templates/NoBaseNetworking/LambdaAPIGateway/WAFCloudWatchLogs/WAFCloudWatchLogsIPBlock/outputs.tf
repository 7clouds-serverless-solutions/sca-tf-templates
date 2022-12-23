output "REST_API_ENDPOINT" {
  description = "API Gateway swagger endpoint URL for current stage"
  value       = module.lambda_api_gateway.REST_API_ENDPOINT
}