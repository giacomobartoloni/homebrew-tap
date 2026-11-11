#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# Verify both published macOS DMGs against the pinned cask and release manifest.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

ruby - "$root/Casks/mathboard.rb" > "$tmp/cask.txt" <<'RUBY'
cask = File.read(ARGV.fetch(0))
version = cask.match(/^\s*version "([0-9]+\.[0-9]+\.[0-9]+)"$/)
hashes = cask.match(/^\s*sha256 arm:\s*"([a-f0-9]{64})",\s*\n\s*intel:\s*"([a-f0-9]{64})"$/)
url = 'url "https://github.com/giacomobartoloni/mathboard/releases/download/v#{version}/MathBoard_#{version}_#{arch}.dmg"'
abort "Unexpected MathBoard cask layout" unless cask.include?('cask "mathboard"') && cask.include?(url) && version && hashes
puts [version[1], hashes[1], hashes[2]].join(' ')
RUBY
read -r version arm_sha intel_sha < "$tmp/cask.txt"

release="https://github.com/giacomobartoloni/mathboard/releases/download/v${version}"
curl --fail --location --silent --show-error --retry 3 \
  --output "$tmp/SHA256SUMS.txt" "$release/SHA256SUMS.txt"

for arch in aarch64 x64; do
  file="MathBoard_${version}_${arch}.dmg"
  if [[ "$arch" == "aarch64" ]]; then expected="$arm_sha"; else expected="$intel_sha"; fi

  ruby - "$tmp/SHA256SUMS.txt" "$file" "$expected" <<'RUBY'
manifest, filename, expected = ARGV
entries = File.readlines(manifest, chomp: true).filter_map do |line|
  match = line.match(/\A([a-f0-9]{64})  (\S+)\z/)
  abort "Malformed SHA256SUMS.txt entry" unless match
  [match[2], match[1]]
end
matches = entries.select { |name, _| name == filename }
abort "Missing or duplicate checksum for #{filename}" unless matches.size == 1
abort "Cask checksum differs from release manifest for #{filename}" unless matches[0][1] == expected
RUBY

  curl --fail --location --silent --show-error --retry 3 \
    --output "$tmp/$file" "$release/$file"
  actual="$(shasum -a 256 "$tmp/$file" | awk '{print $1}')"
  if [[ "$actual" != "$expected" ]]; then
    echo "SHA-256 mismatch for $file" >&2
    exit 1
  fi
  echo "Verified $file: $actual"
done
