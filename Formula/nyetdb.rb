class Nyetdb < Formula
  desc "Read-only database access for AI agents. Your agent can look; for everything else — nyet."
  homepage "https://github.com/stasmarkin/nyetdb"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.2.0/nyetdb-aarch64-apple-darwin.tar.xz"
      sha256 "535939bdfa1a4c499b87744646aec3e6af6e9167d7308b44595e0f8157252110"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.2.0/nyetdb-x86_64-apple-darwin.tar.xz"
      sha256 "ed32eb1e09a78a1947d2f08496677db5e1b1e5a94725b63d4e27fe6a4d2c443f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.2.0/nyetdb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e3e56be4daf6122610330302096d54c6a0e681fa3566f3ed37f35b2df24e9f92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.2.0/nyetdb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "945ac337707ae2999f098ae7a500fdf610b535e5168f81267cef1c177a5bc590"
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
