# Buat bucket S3 untuk menyimpan Terraform state
aws s3api create-bucket --bucket digdat-terraform-state-storage --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1

# 1. Konfigurasi JSON
$blockConfig = @{
  BlockPublicAcls = $true
  IgnorePublicAcls = $true
  BlockPublicPolicy = $true
  RestrictPublicBuckets = $true
} | ConvertTo-Json -Compress -Depth 1
$escapedConfig = '"' + $blockConfig.Replace('"', '\"') + '"'
aws s3api put-public-access-block `
  --bucket digdat-terraform-state-storage `
  --public-access-block-configuration $escapedConfig

# Buat DynamoDB table untuk state locking (opsional tapi disarankan)
aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region ap-southeast-1
