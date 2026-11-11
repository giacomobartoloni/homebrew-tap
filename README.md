# MathBoard Homebrew Tap

Homebrew cask for the [MathBoard](https://mathboard.app/) desktop application on macOS. It installs official DMG artifacts from [MathBoard GitHub Releases](https://github.com/giacomobartoloni/mathboard/releases).

## Install

```sh
brew install --cask giacomobartoloni/tap/mathboard
```

The cask selects the appropriate DMG for Apple Silicon (`aarch64`) or Intel (`x64`), verifies its SHA-256 checksum, and installs `MathBoard.app` in the standard macOS Applications directory.

MathBoard is currently an unsigned, unnotarized beta, so macOS Gatekeeper may block its first launch. Prefer macOS's per-app **System Settings > Privacy & Security > Open Anyway** flow. If you trust the installed build and explicitly choose to remove the downloaded-app quarantine attribute for MathBoard only, run:

```sh
sudo xattr -r -d com.apple.quarantine "/Applications/MathBoard.app"
```

**Security note:** This command bypasses macOS quarantine-based checks for this app; it does not sign or notarize MathBoard. Do not use it for software you have not verified or on a device whose security policy prohibits it.

## Update

```sh
brew update
brew upgrade --cask giacomobartoloni/tap/mathboard
```

The cask version is maintained in this repository. An upstream release does not become available through Homebrew until the cask version and checksums are updated.

## Uninstall

```sh
brew uninstall --cask giacomobartoloni/tap/mathboard
```

This tap does not define a `zap` action, so uninstalling will not intentionally delete your locally saved MathBoard boards or settings.

## Security and public beta status

MathBoard's current macOS desktop builds are **unsigned public betas**: they are not signed with an Apple Developer ID certificate and are not notarized by Apple. Installing via Homebrew does **not** change that trust status or bypass macOS Gatekeeper.

Download only from the official release referenced by the cask. If macOS prevents the first launch, review the project's [unsigned beta installation guidance](https://github.com/giacomobartoloni/mathboard/blob/main/docs/desktop/UNSIGNED_BETA.md) and [Apple's per-app instructions](https://support.apple.com/en-us/102445). Do not disable Gatekeeper globally. The optional quarantine-removal command above is less conservative than the project's security guide, which advises against removing quarantine attributes.

Homebrew verifies the downloaded archive against the SHA-256 values pinned in [`Casks/mathboard.rb`](Casks/mathboard.rb). Checksums help detect changes to the artifact, but do not establish a verified publisher identity.

## Automated update pull requests

An approved, published MathBoard desktop release can open or refresh a pull request
against this tap's `main` branch. The upstream workflow runs in
[`giacomobartoloni/mathboard`](https://github.com/giacomobartoloni/mathboard);
it never merges a tap PR or publishes installers. The generated PR must update
only `Casks/mathboard.rb`. Review the release, version, both architecture-specific
SHA-256 hashes, unsigned-beta disclosures, and the CI results before merging.

The `Validate MathBoard cask` pull-request workflow performs Ruby syntax
validation and `brew audit --cask`, then downloads both published macOS DMGs and
checks their actual SHA-256 hashes against the cask and official release manifest.
A passing checksum check does **not** prove developer identity, notarization,
or native installation/GUI acceptance on both Mac architectures. These checks
are distinct from the desktop release's manual platform QA requirements.

The workflow can be run manually from GitHub Actions to recheck the current cask.
After a reviewed PR is merged, users can upgrade normally:

```sh
brew update
brew upgrade --cask giacomobartoloni/tap/mathboard
```

## Maintaining the cask

After a new public desktop release has been reviewed and published:

1. Confirm the published tag follows `vMAJOR.MINOR.PATCH` and contains both `MathBoard_VERSION_aarch64.dmg` and `MathBoard_VERSION_x64.dmg`.
2. Update `version` and the architecture-specific SHA-256 hashes in `Casks/mathboard.rb` using the **published** GitHub Release assets.
3. Verify the URLs, hashes and cask syntax; on macOS, run `brew audit --cask giacomobartoloni/tap/mathboard` and test the installation.
4. Commit the reviewed changes to this tap. Do not automatically publish draft releases, release candidates or unverified installers.

MathBoard source code and release documentation: https://github.com/giacomobartoloni/mathboard

Reference distribution approach: [NearDrop Homebrew tap](https://github.com/grishka/homebrew-grishka).
