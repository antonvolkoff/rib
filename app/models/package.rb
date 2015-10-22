class Package < ActiveRecord::Base
  has_many :versions, :class_name => "PackageVersion"

  validates :name, presence: true, uniqueness: true

  def self.create_from_package_info!(info)
    Package.create!(
      name:             info["Package"],
      current_version:  info["Version"],
      payload:          info
    )
  end
end
