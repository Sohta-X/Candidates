class CandidateDetail < ActiveRecord::Base
  belongs_to :candidate

  KIND = { "LinkedIn" => 1, "Xing" => 2, "Facebook" => 3}
end
