class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :team_no
      t.integer :category
      t.integer :point

      t.timestamps
    end
  end
end
