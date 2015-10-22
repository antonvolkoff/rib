class StorePackage
  include Interactor

  def call
    package = Package.find_by_name(context.info["Package"])
    if package.nil?
      package = Package.create!(
        name:             context.info["Package"],
        current_version:  context.info["Version"],
        payload:          context.info
      )
    end

    version = package.versions.find_by_version(context.info["Version"])
    if version.nil?
      rpackage = RProject::RPackage.new(context.info["Package"], context.info["Version"])
      version = package.versions.create!(
        name:     context.info["Package"],
        version:  context.info["Version"],
        payload:  rpackage.description,
      )
      package.update_attribute(:current_version, context.info["Version"])
    end
  end
end
