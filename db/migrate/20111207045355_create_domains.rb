class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :domain
      t.integer :user_id
      t.date :registration_date
      t.date :expiration_date

      t.timestamps
    end
  end
end
