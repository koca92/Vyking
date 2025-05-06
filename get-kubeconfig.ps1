param (
    [string]$MasterIP,
    [string]$PrivateKeyPath
)

if (-not $MasterIP -or -not $PrivateKeyPath) {
    Write-Host "Usage: .\get-kubeconfig.ps1 -MasterIP <master_ip> -PrivateKeyPath <path_to_private_key.pem>"
    exit 1
}
Write-Host & ssh -o StrictHostKeyChecking=no -i "${PrivateKeyPath}" "vagrant@${MasterIP}" "sudo chmod 777 /etc/rancher/k3s/k3s.yaml"

Write-Host "Fetching kubeconfig from master node at $MasterIP ..."

# Use scp to copy the kubeconfig
scp -i "${PrivateKeyPath}" -o StrictHostKeyChecking=no vagrant@${MasterIP}:/etc/rancher/k3s/k3s.yaml ./
#scp -i 'C:\DevOps-Exam-Solution\New folder\key\insecure_private_key.pem' -o StrictHostKeyChecking=no vagrant@192.168.0.14:/etc/rancher/k3s/k3s.yaml k3s.yaml
ssh -o StrictHostKeyChecking=no -i ".\\key\\insecure_private_key.pem" "vagrant@${MasterIP}" "sudo chmod 600 /etc/rancher/k3s/k3s.yaml"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to fetch kubeconfig."
    exit 1
}

# Replace 127.0.0.1 with real Master IP in the kubeconfig
(Get-Content ./k3s.yaml) -replace "127.0.0.1", "$MasterIP" | Set-Content ./k3s.yaml

$env:KUBECONFIG = "k3s.yaml"
kubectl config get-contexts
kubectl get nodes

Write-Host "Kubeconfig fetched successfully!"

.\scripts\ArgoInstall.ps1