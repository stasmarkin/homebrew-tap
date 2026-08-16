class Nyetdb < Formula
  desc "Read-only database access for AI agents. Your agent can look; for everything else — nyet."
  homepage "https://github.com/stasmarkin/nyetdb"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.0/nyetdb-aarch64-apple-darwin.tar.xz"
      sha256 "514c7278489c61d107af0ad6ced7686a483c040ac0acd6cf73485d140a1bbde9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.0/nyetdb-x86_64-apple-darwin.tar.xz"
      sha256 "1ff93c1a6844be194abf56b499d87ec5caeb38d209a3b677fdc988cf2a7da9f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.0/nyetdb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea65b7e6285efd9e18357312c635bc57ffceb63fac5e5a12b1f45b72b2c9c24f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.0/nyetdb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "277f9d043b08cc50c52e4fd1db7178fe399d7c273da4bc14c1263766cc2af718"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nyet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nyet"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "nyet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nyet"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
