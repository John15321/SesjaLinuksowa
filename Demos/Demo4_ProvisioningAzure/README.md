Demo 4: Provisioning Flatcar on Azure (CLI)

Deploy a Flatcar VM on Azure using az CLI commands.

Change NAME_SUFFIX in the Makefile to your initials to avoid resource group collisions.


0. PREREQ

  az login


1. GENERATE IGNITION CONFIG (make config.ign)

  butane --strict < config.bu > config.ign


2. ACCEPT MARKETPLACE TERMS (make accept-terms)

  az vm image terms accept \
    --publisher kinvolk \
    --offer flatcar-container-linux-free \
    --plan stable-gen2


3. CREATE RESOURCE GROUP

  az group create --name flatcar-demo-jb-rg --location westeurope


4. DEPLOY THE VM (make deploy does steps 2-4)

  az vm create \
    --resource-group flatcar-demo-jb-rg \
    --name flatcar-demo-jb-vm \
    --image kinvolk:flatcar-container-linux-free:stable-gen2:latest \
    --size Standard_B2s \
    --admin-username core \
    --ssh-key-values ~/.ssh/id_ed25519.pub \
    --custom-data @config.ign \
    --plan-name stable-gen2 \
    --plan-publisher kinvolk \
    --plan-product flatcar-container-linux-free


5. GET THE PUBLIC IP

  az vm show -g flatcar-demo-jb-rg -n flatcar-demo-jb-vm -d --query publicIps -o tsv


6. SSH INTO THE VM (make ssh)

  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null core@<IP_FROM_STEP_5>


7. EXPLORE -- inside the VM

  cat /etc/os-release
  journalctl -u hello-world.service
  uname -a


8. CLEAN UP (make clean)

  az group delete --name flatcar-demo-jb-rg --yes --no-wait
  rm -f config.ign
