class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :team_no
      t.integer :point1
      t.integer :point2
      t.integer :point3

      t.timestamps
    end
  end
end
