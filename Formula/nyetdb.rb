class Nyetdb < Formula
  desc "Read-only database access for AI agents. Your agent can look; for everything else — nyet."
  homepage "https://github.com/stasmarkin/nyetdb"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.1/nyetdb-aarch64-apple-darwin.tar.xz"
      sha256 "d67dfd8e3b3d45e6e3c28e87b818bbd312635dec26789abb8c6b0d758c07d018"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.1/nyetdb-x86_64-apple-darwin.tar.xz"
      sha256 "50e92a0f77f7799fd0e00777d7a8430909eaad0166f446b0b16e12d711be1538"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.1/nyetdb-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e874f87ea20dc586bcdf334f219ba98704da3537c89f784032547437323b96c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stasmarkin/nyetdb/releases/download/v0.3.1/nyetdb-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "037fba6b9fdbc846ed3278fbb726ecde43201b0676c5f06887ed50b570a04422"
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
