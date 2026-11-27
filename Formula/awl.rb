# SPDX-License-Identifier: AGPL-3.0-only

class Awl < Formula
  desc "Local-first CLI for Markdown-based coding-agent worklogs"
  homepage "https://github.com/giacomobartoloni/awl"
  license "AGPL-3.0-only"

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/giacomobartoloni/awl/releases/download/v0.3.0/awl_0.3.0_darwin_arm64.tar.gz"
      sha256 "bd3665fe180a3996e31207cef61ef5d9b2e35160a148b38da511c241be26528f"
    end

    on_intel do
      url "https://github.com/giacomobartoloni/awl/releases/download/v0.3.0/awl_0.3.0_darwin_amd64.tar.gz"
      sha256 "cbf170168aa2d3ebdd3e43ac1d31c947ddedee3db0bcf2054a8207e592db9cd4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/giacomobartoloni/awl/releases/download/v0.3.0/awl_0.3.0_linux_arm64.tar.gz"
      sha256 "5a879e4d62b7b6d8cb3567f05ce23fe7cd09ddc78842715e879da93ef5bd1677"
    end

    on_intel do
      url "https://github.com/giacomobartoloni/awl/releases/download/v0.3.0/awl_0.3.0_linux_amd64.tar.gz"
      sha256 "a434b38a6eec89cfff8988092f2acd44f6354ae621aa8c5325aaefce40326ece"
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
