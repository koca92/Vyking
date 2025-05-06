$cripted = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' 
[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($cripted))