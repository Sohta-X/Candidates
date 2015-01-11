class Candidate < ActiveRecord::Base
  belongs_to :city
  belongs_to :country

  has_many :candidate_memos
  accepts_nested_attributes_for :candidate_memos
  has_many :candidate_details
  accepts_nested_attributes_for :candidate_details
  has_one :candidate_progress
  accepts_nested_attributes_for :candidate_progress

  STATUS = { "got_contact" => 1, "approached_with_linkedin" => 2, "approached_with_email" => 3, "approached_with_xing" => 4, "approached_with_facebook" => 5}
  Probability = {"No" => 0, "Yes" => 1}
  KIND = {"entreprenuer" => 1, "assistant" => 2, "tutor" => 3}
end
