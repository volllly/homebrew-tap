require "open3"

class Rotz < Formula
  desc "Fully cross platform dotfile manager and dev environment bootstrapper"
  homepage "https://volllly.github.io/rotz/"
  url "https://github.com/volllly/rotz/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "e769293c59672e794d017c7a13eae521180821dac2bf758f0c6875d2a1f169f1"
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
