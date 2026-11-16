# SPDX-License-Identifier: AGPL-3.0-only

class Awl < Formula
  desc "Local-first CLI for Markdown-based coding-agent worklogs"
  homepage "https://github.com/giacomobartoloni/awl"
  version "0.2.0"
  license "AGPL-3.0-only"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/giacomobartoloni/awl/releases/download/v#{version}/awl_#{version}_darwin_arm64.tar.gz"
      sha256 "7a90f19e8b2d51d351ed5dbae112fbcef7798c766ab049e77464ce25ad278169"
    end

    on_intel do
      url "https://github.com/giacomobartoloni/awl/releases/download/v#{version}/awl_#{version}_darwin_amd64.tar.gz"
      sha256 "2ed74ece8a120fe0c7279571f2b5988cc62133a87d92a2b0032aaa5b41d260b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/giacomobartoloni/awl/releases/download/v#{version}/awl_#{version}_linux_arm64.tar.gz"
      sha256 "9c71a8044746daab98027d22b0f07a5ce7f53911e0a9ce894372f5f4616f17bc"
    end

    on_intel do
      url "https://github.com/giacomobartoloni/awl/releases/download/v#{version}/awl_#{version}_linux_amd64.tar.gz"
      sha256 "b85eaee3f6b76e62fd51cc60bf4427e2135911e59484566c8499d926d7334d9e"
    end
  end

  def install
    bin.install "awl"
  end

  test do
    assert_match "awl #{version}", shell_output("#{bin}/awl --version")
    assert_match "Usage:", shell_output("#{bin}/awl --help")
  end
end
