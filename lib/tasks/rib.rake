namespace :rib do
  desc "Fetch 50 packages"
  task fetch: :environment do
    puts "Fetching list of packages..."
    packages = RProject.new.packages(50)


    puts "Storing packages..."
    Parallel.each(packages) do |package|
      puts "#{package["Package"]} [Done]"
      begin
        StorePackage.call(info: package)
      rescue Exception => e
        puts "#{package["Package"]} [Error] #{e}"
      end
    end
  end
end
