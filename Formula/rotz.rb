require "open3"

class Rotz < Formula
  desc "Fully cross platform dotfile manager and dev environment bootstrapper"
  homepage "https://volllly.github.io/rotz/"
  url "https://github.com/volllly/rotz/archive/refs/tags/v0.9.5.tar.gz"
  sha256 "6b6742ffbcd2013c394fa3f50b6890eb84c5b7e9e2854daecfdc3cbd4106f3dc"
  license "MIT"
  head "https://github.com/volllly/rotz.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features", "all-formats", *std_cargo_args
  end

  test do
    assert_match "rotz #{version}\n", shell_output("#{bin}/rotz -V")

    out, status = Open3.capture2e("rotz link")

    assert_not_equal(0, status)

    assert_match(/Error: dotfiles::walk/, out)
    assert_match(/The system cannot find the file specified/, out)
  end
end
