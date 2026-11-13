# SPDX-License-Identifier: AGPL-3.0-or-later

cask "mathboard" do
  arch arm: "aarch64", intel: "x64"

  version "1.13.0"
  sha256 arm:   "d9379ed8b29f0d967bdb64d19312d08f0a5854ed1dd37fefb90dc621591d32c4",
         intel: "1e54725ef4b86d03c8f0413e5d3768f403995afa61d4bce896a2bd1b250caa1b"

  url "https://github.com/giacomobartoloni/mathboard/releases/download/v#{version}/MathBoard_#{version}_#{arch}.dmg"
  name "MathBoard"
  desc "Open-source math whiteboard for teachers and tutors"
  homepage "https://mathboard.app/"

  depends_on :macos

  app "MathBoard.app"

  caveats <<~EOS
    MathBoard is currently an unsigned, unnotarized public beta.
    Installation via Homebrew does not bypass macOS Gatekeeper.
    See: https://github.com/giacomobartoloni/mathboard/blob/main/docs/desktop/UNSIGNED_BETA.md
  EOS
end
