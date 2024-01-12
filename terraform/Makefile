.PHONY: staging-init
staging-init: ## initialize terraform in staging environment
	terraform workspace select staging
	terraform workspace show
	terraform init

.PHONY: staging-validate
staging-validate: ## format and validate terraform in staging environment
	terraform workspace select staging
	terraform workspace show
	terraform fmt -recursive
	terraform validate

.PHONY: staging-plan
staging-plan: ## plan for staging environment
	terraform workspace select staging
	terraform workspace show
	terraform validate
	terraform plan -var-file="terraform_staging.tfvars"

.PHONY: staging-apply
staging-apply: ## apply changes to staging environment
	terraform workspace select staging
	terraform workspace show
	terraform apply -var-file="terraform_staging.tfvars"

.PHONY: staging-destroy
staging-destroy: ## destroy staging environment
	terraform workspace select staging
	terraform workspace show
	terraform destroy -var-file="terraform_staging.tfvars"

.PHONY: prod-init
prod-init: ## initialize terraform in prod environment
	terraform workspace select prod
	terraform workspace show
	terraform init

.PHONY: prod-validate
prod-validate: ## format and validate terraform in prod environment
	terraform workspace select prod
	terraform workspace show
	terraform fmt -recursive
	terraform validate

.PHONY: prod-plan
prod-plan: ## plan for prod environment
	terraform workspace select prod
	terraform workspace show
	terraform validate
	terraform plan -var-file="terraform_prod.tfvars"

.PHONY: prod-apply
prod-apply: ## apply changes to prod environment
	terraform workspace select prod
	terraform workspace show
	terraform apply -var-file="terraform_prod.tfvars"

.PHONY: prod-destroy
prod-destroy: ## destroy prod environment
	terraform workspace select prod
	terraform workspace show
	terraform destroy -var-file="terraform_prod.tfvars"
