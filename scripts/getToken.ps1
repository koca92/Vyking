param (
    [Parameter(Mandatory=$true)][string]$ip
)
 
$token = & ssh -o StrictHostKeyChecking=no -i ".\\key\\insecure_private_key.pem" "vagrant@$ip" "sudo cat /var/lib/rancher/k3s/server/node-token"

if ($LASTEXITCODE -ne 0 -or -not $token) {
    $errorOut = @{ error = "SSH connection failed or token not found" }
    $json = $errorOut | ConvertTo-Json -Compress
    Write-Output $json
    exit 1
} else {
    $result = @{ token = $token.Trim() }
    $json = $result | ConvertTo-Json -Compress
    Write-Output $json
}
