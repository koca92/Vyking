Steps to deploy:
1. you need to download image focal-server-cloudimg-amd64-vagrant.box
https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box

2. in root variables.tf set your host network_device

3.run terraform init

4. run terraform apply --auto-approve

5. when it finishes you will get command to execute (example: ./get-kubeconfig.ps1 192.168.0.52 .\key\insecure_private_key.pem)
It should run all the scripts automaticly.
if it fails run each scpript manualy in this order:
./get-kubeconfig.ps1 192.168.0.52 .\key\insecure_private_key.pem
.\scripts\ArgoInstall.ps1   
Start-Process pwsh -ArgumentList "-Command kubectl port-forward svc/argocd-server -n argocd 8080:443" 
.\scripts\ArgoAppInstall.ps1