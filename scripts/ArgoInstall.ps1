kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

@'
{
  "spec": {
    "type": "NodePort"
  }
}
'@ | Out-File patch-lb.json -Encoding ascii
kubectl patch svc argocd-server -n argocd --type=merge --patch-file patch-lb.json

kubectl get svc argocd-server -n argocd

Start-Process pwsh -ArgumentList "-Command kubectl port-forward svc/argocd-server -n argocd 8080:443"

.\scripts\ArgoAppInstall.ps1