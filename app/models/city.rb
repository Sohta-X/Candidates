class City < ActiveRecord::Base
  has_many :candidates
  belongs_to :country
end
