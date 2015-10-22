require 'rails_helper'

describe StorePackage do
  let(:package_info) do
    {
      "Package" => "A3",
      "Version" => "1.0.0",
      "Depends" => "R (>= 2.15.0), xtable, pbapply",
      "Suggests" =>  "randomForest, e1071", "License"=>"GPL (>= 2)", "NeedsCompilation"=>"no"
    }
  end
  before do
    rpack = double()
    allow(RProject::RPackage).to receive(:new).with('A3', '1.0.0').and_return(rpack)
    allow(rpack).to receive(:description).and_return({"foo" => "bar"})
  end

  describe '.call' do
    subject(:context) { StorePackage.call(info: package_info) }

    context 'when package does not exist' do
      it 'creates package in db' do
        context
        expect(Package.find_by_name('A3')).to be
      end

      it 'creates package_version in db' do
        context
        expect(PackageVersion.find_by_name('A3')).to be
      end
    end

    context 'when package exist' do
      context 'when package version is the same' do
        before do
          pack = Fabricate(:package, name: 'A3', current_version: '1.0.0')
          Fabricate(:package_version, package: pack,  name: 'A3', version: '1.0.0')
        end

        it 'does not create package' do
          context
          expect(Package.count).to eq(1)
        end

        it 'does not create version' do
          context
          expect(PackageVersion.count).to eq(1)
        end
      end

      context 'when package version is different' do
        let(:pack) { Fabricate(:package, name: 'A3', current_version: '0.9.0') }
        before do
          Fabricate(:package_version, package: pack,  name: 'A3', version: '0.9.0')
        end

        it 'updates current_version for package' do
          context
          pack.reload
          expect(pack.current_version).to eq('1.0.0')
        end

        it 'creates new version' do
          context
          expect(PackageVersion.count).to eq(2)
        end
      end
    end
  end
end
