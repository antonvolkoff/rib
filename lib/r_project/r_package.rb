require 'rubygems/package'

class RProject::RPackage
  BASE_URL = 'http://cran.r-project.org/src/contrib'

  attr_reader :url, :filename

  def initialize(name, version)
    @url      = "#{BASE_URL}/#{name}_#{version}.tar.gz"
    @filename = "#{name}/DESCRIPTION"
  end

  def description
    Dcf.parse(raw_description).first
  end

  private

  def raw_description
    uncompressed = Gem::Package::TarReader.new(Zlib::GzipReader.open(description_file))
    desc_file = uncompressed.detect { |f| f.full_name == filename }
    desc_file.read
  end

  def description_file
    @file ||= open(url)
  end
end
