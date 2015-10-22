namespace :rib do
  desc "Fetch 50 packages"
  task fetch: :environment do
    puts "Fetching list of packages..."
    packages = RProject.new.packages(50)
    print "Storing packages"
    packages.each do |package|
      print "."
      begin
        StorePackage.call(info: package)
      rescue Exception => e
        puts "Error with #{package["Package"]}: #{e}"
      end
    end
    puts "Done"
  end
end
