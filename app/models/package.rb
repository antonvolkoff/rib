class Package < ActiveRecord::Base
  has_many :versions, :class_name => "PackageVersion"

  validates :name, presence: true, uniqueness: true

  def version
    versions.find_by_version(current_version)
  end
end
