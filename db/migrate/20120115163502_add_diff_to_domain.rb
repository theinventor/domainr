class AddDiffToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :page_title_diff, :integer
    add_column :domains, :page_html_diff, :integer
  end
end
