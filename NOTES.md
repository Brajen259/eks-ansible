# NOTES

## Useful commands

```bash
kubectl -n kube-system get secret -o jsonpath='{range .items[*]}{.metadata.annotations.kubernetes\.io/service-account\.name}{"\n"}{end}'
```