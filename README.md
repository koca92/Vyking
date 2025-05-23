# Vyking

## Steps to Deploy

### 1. Download the Image
Download the required image file:  
**[focal-server-cloudimg-amd64-vagrant.box](https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box)**

---

### 2. Set Host Network Device
Update the `network_device` variable in the root file `variables.tf` to match your host's network device.

---

### 3. Initialize Terraform
Run the following command to initialize Terraform:
```bash
terraform init

4. **Apply Terraform Configuration**  
   Run:
   terraform apply --auto-approve

5. **Run Post-Deployment Script**  
   When it finishes, you will get a command to execute. For example:
   ./get-kubeconfig.ps1 192.168.0.52 .\key\insecure_private_key.pem

   It should run all the scripts automatically.

   If it fails, run each script manually in this order:
   ./get-kubeconfig.ps1 192.168.0.52 .\key\insecure_private_key.pem  
   .\scripts\ArgoInstall.ps1  
   Start-Process pwsh -ArgumentList "-Command kubectl port-forward svc/argocd-server -n argocd 8080:443"  
   .\scripts\ArgoAppInstall.ps1
