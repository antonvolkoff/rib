class Package < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
