#!/usr/bin/env bash

set -eu -o pipefail

BASE="$(git rev-parse --show-toplevel)"
VERSIONS=(1.9.1 1.9.2 1.9.3 1.9.4 1.9.5 1.9.6 1.10.0 1.10.1 1.10.2 1.10.3)

main() {
  local version="${1:-}"

  if [[ -n "$version" ]]; then
    package "$version"
  else
    for version in "${VERSIONS[@]}"; do
      package "$version"
    done
  fi
}

package() {
  local version="$1"
  local src="${BASE}/charts/v${version}"

  local chart base
  find "$src" -name Chart.yaml | while read -r chart; do
    base="$(dirname "$chart")"

    # Simplify chart names (remove istio- prefix)
    sed -i.bak -e 's/^name: istio-/name: /' "$chart"
    helm package --destination "${BASE}/packages" "$base"
  done

}

main "$@"
