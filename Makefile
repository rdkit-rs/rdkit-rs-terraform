plan:
	terraform plan -state=github-actions-oidc.tfstate

apply:
	terraform apply -state=github-actions-oidc.tfstate -backup=- -compact-warnings

init:
	terraform init

# I couldn't get it to use the assumerole without running this
reconfigure:
	AWS_PROFILE=scientist terraform init -reconfigure