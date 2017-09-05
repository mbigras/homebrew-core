class Dvdauthor < Formula
  desc "DVD-authoring toolset"
  homepage "https://dvdauthor.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dvdauthor/dvdauthor-0.7.2.tar.gz"
  sha256 "3020a92de9f78eb36f48b6f22d5a001c47107826634a785a62dfcd080f612eb7"

  bottle do
    cellar :any
    sha256 "bd87b4f4e8c33a7a8275ea3b34c8e995f58b61d71a8a7b726d35639868b447c9" => :sierra
    sha256 "f295c54bd810948d3acf3223d7132c036acd9842a4c7fc449ac111f5e6971d9f" => :el_capitan
    sha256 "e91dd3ffd68dd00a08d6c2f72e395dbd95c83a2057ebe19bf0310d1abba4fa04" => :mavericks
  end

  # Dvdauthor will optionally detect ImageMagick or GraphicsMagick, too.
  # But we don't add either as deps because they are big.

  depends_on "pkg-config" => :build
  depends_on "libdvdread"
  depends_on "freetype"
  depends_on "libpng"
  depends_on "libxml2" if MacOS.version <= :el_capitan

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    ENV.deparallelize # Install isn't parallel-safe
    system "make", "install"
  end

  test do
    assert_match "VOBFILE", shell_output("#{bin}/dvdauthor --help 2>&1", 1)
  end
end
