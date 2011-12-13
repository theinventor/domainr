class AddAlertsToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :user_id, :integer
    add_column :alerts, :alert_month, :boolean
    add_column :alerts, :alert_week, :boolean
    add_column :alerts, :alert_day, :boolean
  end
end
