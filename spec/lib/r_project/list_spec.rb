require 'rails_helper'

describe RProject::List do
  let(:packages) do
    <<-PACKAGE
Package: A3
Version: 1.0.0
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
License: GPL (>= 2)
NeedsCompilation: no

Package: abbyyR
Version: 0.2
Depends: R (>= 3.2.0)
Imports: httr, XML, curl, RecordLinkage, readr
License: GPL (>= 2)
NeedsCompilation: no
    PACKAGE
  end
  let(:parsed_packages) do
    [
      {"Package"=>"A3", "Version"=>"1.0.0", "Depends"=>"R (>= 2.15.0), xtable, pbapply", "Suggests"=>"randomForest, e1071", "License"=>"GPL (>= 2)", "NeedsCompilation"=>"no"},
      {"Package"=>"abbyyR", "Version"=>"0.2", "Depends"=>"R (>= 3.2.0)", "Imports"=>"httr, XML, curl, RecordLinkage, readr", "License"=>"GPL (>= 2)", "NeedsCompilation"=>"no"}
    ]
  end

  describe '.packages' do
    subject(:r_project) { RProject::List.new }
    before do
      allow(r_project).to receive(:fetch_package_list).and_return(packages)
    end

    context 'when limit is given' do
      it 'returns limited list of current packages' do
        expect(r_project.packages(1)).to eq(parsed_packages.take(1))
      end
    end

    context 'when limit is not given' do
      it 'returns list of current packages' do
        expect(r_project.packages).to eq(parsed_packages)
      end
    end
  end
end
