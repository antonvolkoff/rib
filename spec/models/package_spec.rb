require 'rails_helper'

RSpec.describe Package, type: :model do
  describe '#create_from_package_info!' do
    let(:package_info) do
      {
        "Package"=> "A3",
        "Version"=> "1.0.0",
        "Depends"=> "R (>= 2.15.0), xtable, pbapply",
        "Suggests"=>  "randomForest, e1071", "License"=>"GPL (>= 2)", "NeedsCompilation"=>"no"
      }
    end

    it 'creates Package' do
      expect(Package).to receive(:create!).with(
        name: "A3",
        current_version: "1.0.0",
        payload: package_info
      )
      Package.create_from_package_info!(package_info)
    end
  end
end
