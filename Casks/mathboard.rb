# SPDX-License-Identifier: AGPL-3.0-or-later

cask "mathboard" do
  arch arm: "aarch64", intel: "x64"

  version "1.12.0"
  sha256 arm:   "438b4599b25356d4505a5a6fc9118aab5bb5c17e14a39771a2c8d8f82d27d696",
         intel: "79bbc51ca66e57f901ba75f87511f844e7f5ae86fe27c81f8616682739857b9c"

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
