class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer :inviter_id
      t.integer :invited_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
