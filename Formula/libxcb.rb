class Libxcb < Formula
  desc "Interface to the X Window System protocol and replacement for Xlib"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://xcb.freedesktop.org/dist/libxcb-1.13.tar.bz2"
  sha256 "188c8752193c50ff2dbe89db4554c63df2e26a2e47b0fa415a70918b5b851daa"
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "7dee4fe51b2082f61b3d0022c0ad89962b15ca1255baceef1bd94fe88b71788d" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-devel-docs", "Build developer documentation"

  depends_on "linuxbrew/xorg/xcb-proto" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "linuxbrew/xorg/libpthread-stubs" # xcb.pc references pthread-stubs
  depends_on "linuxbrew/xorg/libxau"
  depends_on "linuxbrew/xorg/libxdmcp"

  if build.with? "devel-docs"
    depends_on "doxygen" => :build
    depends_on "graphviz" => :build
  end

  if build.with? "test"
    depends_on "check" => :build
    depends_on "libxslt" => [:build, :recommended]
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-dri3
      --enable-ge
      --enable-xevie
      --enable-xprint
      --enable-selinux
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-devel-docs=#{build.with?("devel-docs") ? "yes" : "no"}
      --with-doxygen=#{build.with?("devel-docs") ? "yes" : "no"}
    ]

    ENV["DOT"] = Formula["graphviz"].opt_bin if build.with? "devel-docs"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
