class AddHtmlToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :page_html, :text
    add_column :domains, :page_title, :string
    add_column :domains, :page_h1, :string
    add_column :domains, :page_h2, :string
    add_column :domains, :page_meta, :text
  end
end
