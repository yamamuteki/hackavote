class VoteSummary
	attr_accessor :rank
	attr_accessor :team_no
	attr_accessor :score1
	attr_accessor :score2
	attr_accessor :score3
	
	def total_score
		return @score1 + @score2 + @score3
	end
end
