
#!/usr/bin/env bash
set -euo pipefail

APPLY="${APPLY:-false}"      # APPLY=true ./tf-multi.sh
WORKSPACE="${WORKSPACE:-dev}"
VARFILE="${VARFILE:-}"       # VARFILE=env/dev.tfvars ./tf-multi.sh

mapfile -t TFDIRS < <(find . -type f -name "*.tf" -printf '%h
' | sort -u)

echo "Carpetas Terraform detectadas:"
printf ' - %s
' "${TFDIRS[@]}"

for d in "${TFDIRS[@]}"; do
  echo -e "
=== $d ==="
  pushd "$d" >/dev/null

  # Root detection
  if [[ ! -f "main.tf" ]]; then
    popd >/dev/null; continue
  fi

  terraform fmt -recursive -check >/dev/null
  terraform init -input=false

  if ! terraform workspace list | grep -q " $WORKSPACE"; then
    terraform workspace new "$WORKSPACE" >/dev/null
  fi
  terraform workspace select "$WORKSPACE" >/dev/null

  if [[ -n "$VARFILE" && -f "$VARFILE" ]]; then
    terraform validate
    terraform plan -var-file="$VARFILE" -out=".tfplan"
  else
    terraform validate
    terraform plan -out=".tfplan"
  fi

  if [[ "$APPLY" == "true" ]]; then
    terraform apply -auto-approve ".tfplan"
  fi

  popd >/dev/null
done
