class Libpll < Formula
  # cite Flouri_2015: "https://doi.org/10.1093/sysbio/syu084"
  desc "Phylogenetic likelihood library"
  homepage "http://www.libpll.org/"
  url "https://github.com/xflouris/libpll/archive/0.3.2.tar.gz"
  sha256 "45107d59d87be921c522478bb3688beee60dc79154e0b4a183af01122c597132"
  head "https://github.com/xflouris/libpll.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "flex" => :build unless OS.mac?
  depends_on "bison" => :build unless OS.mac?

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    cp_r doc/"examples"/"heterotachy", testpath
    cd "heterotachy" do
      ENV["CPPFLAGS"] = "-I#{include}/libpll"
      system "make"
      system "./heterotachy"
    end
  end
end
