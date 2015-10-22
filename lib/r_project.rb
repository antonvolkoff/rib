require 'open-uri'

class RProject
  def intitialize
  end

  def packages
    fetch_package_list
    # []
  end

  private

  def fetch_package_list
    @packages ||= open('http://cran.r-project.org/src/contrib/PACKAGES').read
  end
end
