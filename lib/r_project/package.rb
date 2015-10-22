class RProject::Package
  BASE_URL = 'http://cran.r-project.org/src/contrib'

  attr_reader :url

  def initialize(name, version)
    @url = "#{BASE_URL}/#{name}_#{version}.tar.gz"
  end
end
