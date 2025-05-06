$pass = & .\scripts\ArgoGetPassword.ps1
$pass

$path = "guestbook"
$cluster = "guestbook-ui"
.\argocd.exe login 127.0.0.1:8080 --username admin --password ${pass} --insecure
.\argocd.exe app create sock-shop --repo https://github.com/argoproj/argocd-example-apps.git --path $path --dest-server https://kubernetes.default.svc --dest-namespace default
.\argocd.exe app sync sock-shop


$json = kubectl get nodes  -o json | ConvertFrom-Json
$ips = $json.items | ForEach-Object {
    $_.status.addresses | Where-Object { $_.type -eq "InternalIP" } | Select-Object -ExpandProperty address
}
$ip = $ips[1]
$ip

$services = kubectl get svc -n default -o json | ConvertFrom-Json
$port = $services.items | Where-Object { $_.metadata.name -eq "guestbook-ui" }
$pr = $port.spec.ports[0].nodePort
$pr


#.\argocd.exe login ${ip}:${port} --username admin --password ${pass} --insecure


@'
{
  "spec": {
    "type": "NodePort"
  }
}
'@ | Out-File patch.json -Encoding ascii
kubectl patch svc ${cluster} -n default --type=merge --patch-file patch.json

"You can login to Argo with link http://127.0.0.1:8080 
username - admin
password - ${pass}
Link of the app is http://${ip}:${pr}
"