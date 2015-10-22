require 'rails_helper'

describe RProject do
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

    Package: abc
    Version: 2.1
    Depends: R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit
    License: GPL (>= 3)
    NeedsCompilation: no
    PACKAGE
  end

  describe '.packages' do
    subject(:r_project) { RProject.new }
    before do
      allow(r_project).to receive(:fetch_package_list).and_return(packages)
    end

    it 'returns list of current packages' do
      expect(r_project.packages).to eq(packages)
    end
  end
end
