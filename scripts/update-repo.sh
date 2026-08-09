#!/bin/sh

set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ABI="${ABI:-FreeBSD:15:amd64}"
SERIES="${SERIES:-26.7}"
FLAVOUR="${FLAVOUR:-latest}"
REPO_DIR="${REPO_DIR:-${ROOT}/public/${ABI}/${SERIES}/${FLAVOUR}}"
PACKAGE_DIR="${PACKAGE_DIR:-${REPO_DIR}/All}"
REPO_KEY="${REPO_KEY:-${ROOT}/private/unboundviews-repo.key}"

if ! command -v pkg >/dev/null 2>&1; then
    echo "ERROR: pkg is required to generate repository metadata." >&2
    exit 1
fi

if [ ! -f "${REPO_KEY}" ]; then
    echo "ERROR: signing key not found: ${REPO_KEY}" >&2
    exit 1
fi

mkdir -p "${PACKAGE_DIR}"

for package in "$@"; do
    case "${package}" in
        *.pkg) ;;
        *)
            echo "ERROR: expected .pkg file: ${package}" >&2
            exit 1
            ;;
    esac
    cp "${package}" "${PACKAGE_DIR}/"
done

if ! find "${PACKAGE_DIR}" -type f -name '*.pkg' | grep -q .; then
    echo "ERROR: no .pkg files found under ${PACKAGE_DIR}" >&2
    exit 1
fi

pkg repo "${REPO_DIR}" "${REPO_KEY}"
