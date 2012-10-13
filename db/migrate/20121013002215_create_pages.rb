class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url_path, :unique => true
      t.string :title
      t.string :author
      t.text :markdown

      t.timestamps
    end
    add_index(:pages, :url_path, { :unique => true })
  end
end
