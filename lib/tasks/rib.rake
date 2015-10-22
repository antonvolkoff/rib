namespace :rib do
  desc "Fetch 50 packages"
  task :fetch, [:limit] => :environment do |t, args|
    args.with_defaults(limit: 50)
    puts "Fetching list of packages..."
    packages = RProject.new.packages(args[:limit].to_i)


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
