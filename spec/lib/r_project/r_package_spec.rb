require 'rails_helper'

describe RProject::RPackage do
  describe '#new' do
    let(:package_name)    { 'foo' }
    let(:package_version) { '4.2' }
    subject(:package)     { RProject::RPackage.new(package_name, package_version) }

    it 'sets url' do
      expect(package.url).to eq('http://cran.r-project.org/src/contrib/foo_4.2.tar.gz')
    end

    it 'sets filename' do
      expect(package.filename).to eq('foo/DESCRIPTION')
    end
  end

  describe '.description' do
    let(:expected_description) do
      {"Package"=>"A3", "Type"=>"Package", "Title"=>"Accurate, Adaptable, and Accessible Error Metrics for Predictive Models", "Version"=>"1.0.0", "Date"=>"2015-08-15", "Author"=>"Scott Fortmann-Roe", "Maintainer"=>"Scott Fortmann-Roe <scottfr@berkeley.edu>", "Description"=>"Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.", "License"=>"GPL (>= 2)", "Depends"=>"R (>= 2.15.0), xtable, pbapply", "Suggests"=>"randomForest, e1071", "NeedsCompilation"=>"no", "Packaged"=>"2015-08-16 14:17:33 UTC; scott", "Repository"=>"CRAN", "Date/Publication"=>"2015-08-16 23:05:52"}
    end

    let(:package_file) { File.open('./spec/fixtures/A3_1.0.0.tar.gz') }
    subject(:package)     { RProject::RPackage.new('A3', '1.0.0') }
    before do
      allow(package).to receive(:description_file).and_return(package_file)
    end

    it 'returns parsed description file' do
      expect(package.description).to eq(expected_description)
    end
  end
end
