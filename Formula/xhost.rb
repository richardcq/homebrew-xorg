class Xhost < Formula
  desc "X.Org Applications: xhost"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xhost-1.0.7.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xhost-1.0.7.tar.bz2"
  sha256 "93e619ee15471f576cfb30c663e18f5bc70aca577a63d2c2c03f006a7837c29a"
  # tag "linuxbrew"

  bottle do
    cellar :any_skip_relocation
    sha256 "44654e8fde19bf1d959066ee8377ba29513becfdfe330be5e12958adc0c6caba" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/xorgproto" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxmu"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-unix-transport
      --enable-tcp-transport
      --enable-ipv6
      --enable-local-transport
      --enable-secure-rpc
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
