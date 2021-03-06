class Xkeyboardconfig < Formula
  desc "Keyboard configuration database for the X Window System"
  homepage "https://xorg.freedesktop.org"
  url "https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-2.24.tar.bz2"
  mirror "ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.24.tar.bz2"
  sha256 "91b18580f46b4e4ea913707f6c8d68ab5286879c3a6591462f3b9e760d3ac4d7"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "c462f768fe3213b2f744b08be8b1b133b7ea7d9cc186805d951a69dcfb01922e" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext" => :build
  depends_on "libxslt" => :build

  def install
    # Needed by intltool (xml::parser)
    ENV.prepend_path "PERL5LIB", "#{Formula["intltool"].libexec}/lib/perl5"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xkb-rules-symlink=xorg
      --disable-runtime-deps
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
