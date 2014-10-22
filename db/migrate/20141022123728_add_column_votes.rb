class AddColumnVotes < ActiveRecord::Migration
  def change
  	remove_column :votes, :point1, :integer
  	remove_column :votes, :point2, :integer
  	remove_column :votes, :point3, :integer
  end
end
