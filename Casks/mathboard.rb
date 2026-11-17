# SPDX-License-Identifier: AGPL-3.0-or-later

cask "mathboard" do
  arch arm: "aarch64", intel: "x64"

  version "1.14.0"
  sha256 arm:   "83329ab8caa9a94f4830f4d4e729500adc03c78242959ddf0716d9d1048f3743",
         intel: "3b55c843925084ff5157ab82451025d846c643884daabcd04ab1bc926cd15c4d"

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
