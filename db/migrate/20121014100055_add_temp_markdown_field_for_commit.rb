class AddTempMarkdownFieldForCommit < ActiveRecord::Migration
  def change
    add_column :commits, :markdown_temp, :text
  end
end
