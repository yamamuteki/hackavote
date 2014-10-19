class Vote2 < ActiveRecord::Base
	def total_point
		return point1 + point2 + point3
	end
end
