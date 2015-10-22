require 'rails_helper'

describe RProject::Package do
  describe '#new' do
    let(:package_name)    { 'foo' }
    let(:package_version) { '4.2' }
    subject(:package)     { RProject::Package.new(package_name, package_version) }

    it 'sets url' do
      expect(package.url).to eq('http://cran.r-project.org/src/contrib/foo_4.2.tar.gz')
    end
  end
end
