NAME_SUFFIX ?= jb
RG_NAME    ?= flatcar-demo-$(NAME_SUFFIX)-rg
LOCATION   ?= westeurope
VM_NAME    ?= flatcar-demo-$(NAME_SUFFIX)-vm
VM_SIZE    ?= Standard_B2s

.PHONY: all deploy accept-terms ssh clean

all: config.ign

config.ign: config.bu
	butane --strict < config.bu > $@

accept-terms:
	az vm image terms accept \
		--publisher kinvolk \
		--offer flatcar-container-linux-free \
		--plan stable-gen2

deploy: config.ign accept-terms
	az group create --name $(RG_NAME) --location $(LOCATION)
	az vm create \
		--resource-group $(RG_NAME) \
		--name $(VM_NAME) \
		--image kinvolk:flatcar-container-linux-free:stable-gen2:latest \
		--size $(VM_SIZE) \
		--admin-username core \
		--ssh-key-values "$(firstword $(wildcard ~/.ssh/id_ed25519.pub ~/.ssh/id_rsa.pub))" \
		--custom-data @config.ign \
		--plan-name stable-gen2 \
		--plan-publisher kinvolk \
		--plan-product flatcar-container-linux-free

ssh:
	$(eval VM_IP := $(shell az vm show -g $(RG_NAME) -n $(VM_NAME) -d --query publicIps -o tsv))
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null core@$(VM_IP)

clean:
	az group delete --name $(RG_NAME) --yes --no-wait
	rm -f config.ign
