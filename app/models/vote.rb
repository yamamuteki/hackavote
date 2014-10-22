class Vote < ActiveRecord::Base
	validates :team_no, :presence => true
end
