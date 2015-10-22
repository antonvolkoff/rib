require 'open-uri'
require 'dcf'

class RProject
  def intitialize
  end

  def packages
    parsed_packages
  end

  private

  def parsed_packages
    @parsed_packages ||= Dcf.parse(fetch_package_list)
  end

  def fetch_package_list
    @packages ||=open('http://cran.r-project.org/src/contrib/PACKAGES').read
  end
end
