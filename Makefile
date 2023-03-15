plan:
	terraform plan

apply:
	terraform apply -backup=- -compact-warnings

init:
	terraform init

# I couldn't get it to use the assumerole without running this
reconfigure:
	AWS_PROFILE=scientist terraform init -reconfigure
