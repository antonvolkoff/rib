require 'rubygems/package'

# From: http://winstonyw.com/2013/10/02/openuris_open_tempfile_and_stringio/
# Don't allow downloaded files to be created as StringIO. Force a tempfile to be created.
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

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
    desc_file.read.force_encoding('UTF-8')
  end

  def description_file
    @file ||= open(url)
  end
end
