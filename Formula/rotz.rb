class Rotz < Formula
  desc "Fully cross platform dotfile manager and dev environment bootstrapper written in Rust. "
  homepage " volllly.github.io/rotz/"
  version "0.9.5"
  url "https://github.com/volllly/rotz/archive/refs/tags/v#{version}.tar.gz"
  sha256 "6b6742ffbcd2013c394fa3f50b6890eb84c5b7e9e2854daecfdc3cbd4106f3dc"
  license "MIT"
  head "https://github.com/volllly/rotz.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features", "all-formats", *std_cargo_args
  end

  test do
    assert_match "rotz #{version}\n", shell_output("#{bin}/rotz -V")

    err = capture(:stderr) { system bin/"rotz", "link" }
    
    assert_match /Error\: dotfiles\:\:walk/, err
    assert_match /The system cannot find the file specified/, err
  end
end
