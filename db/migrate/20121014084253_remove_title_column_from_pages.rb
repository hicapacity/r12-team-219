class RemoveTitleColumnFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :title
  end
end
