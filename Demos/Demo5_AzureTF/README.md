Demo 5: Provisioning Flatcar on Azure (OpenTofu)

Same result as Demo 4 but fully declarative with OpenTofu.

Change name_suffix in variables.tf to your initials to avoid resource group collisions.


0. PREREQ

  az login
  tofu --version


1. GENERATE IGNITION CONFIG (make config.ign)

  butane --strict < config.bu > config.ign


2. INIT (make init)

  tofu init


3. DEPLOY (make deploy) -- review the plan, type yes

  tofu apply


4. GET SSH COMMAND

  tofu output ssh_command


5. SSH INTO THE VM (make ssh)

  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null core@$(tofu output -raw public_ip)


6. EXPLORE -- inside the VM

  cat /etc/os-release
  journalctl -u hello-world.service


7. CLEAN UP (make destroy)

  tofu destroy


8. FULL CLEAN (make clean) -- remove state and local files too

  rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup config.ign

(or just: make clean)
