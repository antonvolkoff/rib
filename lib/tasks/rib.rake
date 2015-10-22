namespace :rib do
  desc "Fetch 50 packages"
  task fetch: :environment do
    packages = RProject.new.packages(50)
    packages.each do { |package| Package.create_from_package_info!(package) }
  end
end
