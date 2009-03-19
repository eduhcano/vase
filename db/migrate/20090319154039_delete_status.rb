class DeleteStatus < ActiveRecord::Migration
  def self.up
    remove_column :friends, :status
    remove_column :friends, :updated_at
  end

  def self.down
    add_column :friends, :updated_at, :datetime
    add_column :friends, :status, :integer
  end
end
