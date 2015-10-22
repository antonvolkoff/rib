namespace :rib do
  desc "Fetch 50 packages"
  task fetch: :environment do
    packages = RProject.new.packages(50)
    packages.each { |package| Package.create_from_package_info!(package) }
  end
end
