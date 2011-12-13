class AddAlertsToUser < ActiveRecord::Migration
  def change
    add_column :users, :alert_month, :boolean
    add_column :users, :alert_week, :boolean
    add_column :users, :alert_day, :boolean
  end
end
