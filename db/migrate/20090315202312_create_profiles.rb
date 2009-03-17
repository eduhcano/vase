class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer   :user_id
      t.string    :first_name
      t.string    :last_name
      t.string    :address, :city, :zip, :state, :country
      t.string    :website, :company
      t.string    :time_zone, :default => "UTC"
      t.string    :language, :size => 2, :default => 'es'
      
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
