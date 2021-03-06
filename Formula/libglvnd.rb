class Libglvnd < Formula
  desc "GL Vendor-Neutral Dispatch library"
  homepage "https://github.com/NVIDIA/libglvnd"
  url "https://github.com/NVIDIA/libglvnd/releases/download/v1.1.0/libglvnd-1.1.0.tar.gz"
  sha256 "f5a74598e769d55d652c464cb6507437dac5c2d513f16c6ddf3a1bec655a1824"
  head "https://github.com/NVIDIA/libglvnd.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "488e941253ffa45a85715b7d8f7386ebc1a934108898010fe2d6b4704f3d6a86" => :x86_64_linux
  end

  option "without-asm", "Build without assembly"
  option "without-tls", "Build without TLS support"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "linuxbrew/xorg/libpthread-stubs" => :build
  depends_on "linuxbrew/xorg/libxext" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "python@2" => :build

  if build.head?
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end
  depends_on "linuxbrew/xorg/libx11"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-asm=#{build.with?("asm") ? "yes" : "no"}
      --enable-tls=#{build.with?("tls") ? "yes" : "no"}
    ]

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
