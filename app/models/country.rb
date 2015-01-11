class Country < ActiveRecord::Base
  has_many :candidates
  has_many :cities
end
