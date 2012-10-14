class RemoveCommitFieldsFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :commit
    remove_column :pages, :author
    remove_column :pages, :markdown
  end
end
