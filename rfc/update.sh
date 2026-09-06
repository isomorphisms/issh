#!/bin/sh
set -eu

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
manifest="$here/MANIFEST.tsv"
out="$here/text"
tab=$(printf '\t')

mkdir -p "$out"

while IFS="$tab" read -r rfc role title; do
    case "$rfc" in
        ''|'#'*) continue ;;
    esac

    url="https://www.rfc-editor.org/rfc/rfc${rfc}.txt"
    target="$out/rfc${rfc}.txt"
    tmp="$target.tmp"

    printf '%s\n' "RFC $rfc  $title"
    curl --fail --location --silent --show-error --retry 3 \
        --output "$tmp" "$url"

    if [ -f "$target" ] && cmp -s "$tmp" "$target"; then
        rm -f "$tmp"
    else
        mv "$tmp" "$target"
    fi
done < "$manifest"

(
    cd "$here"
    sha256sum text/rfc*.txt > SHA256SUMS
)
