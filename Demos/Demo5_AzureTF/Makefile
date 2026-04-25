.PHONY: all init deploy ssh destroy clean

all: config.ign

config.ign: config.bu
	butane --strict < config.bu > $@

init:
	tofu init

deploy: config.ign init
	tofu apply

ssh:
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null core@$$(tofu output -raw public_ip)

destroy:
	tofu destroy

clean: destroy
	rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup config.ign
