# SPDX-License-Identifier: AGPL-3.0-or-later

cask "mathboard" do
  arch arm: "aarch64", intel: "x64"

  version "1.11.0"
  sha256 arm:   "10042f938feaa9cdfe22bffeb90312472a53c026ee4a5b55fd7a75f1a4c995fd",
         intel: "f41a89cb1b17568219407d07a5be1f4e9da38fccf3f5fd20e21e8ca4bf519d77"

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
