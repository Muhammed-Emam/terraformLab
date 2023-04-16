terraform {
  backend "s3" {
    bucket = "terraform-bucket-emam"
    dynamodb_table = "terraform-state-lock"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}





# aws dynamodb create-table --table-name my-lock-table \
# --attribute-definitions AttributeName=LockID,AttributeType=S \
# --key-schema AttributeName=LockID,KeyType=HASH \
# --billing-mode PAY_PER_REQUEST



#terraform apply -lock-timeout=10s
