class AddAlertsToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :alert_month, :boolean
    add_column :domains, :alert_week, :boolean
    add_column :domains, :alert_day, :boolean
  end
end
