class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.string :title
      t.string :author
      t.text :markdown

      t.timestamps
    end
    add_index(:pages, :path, { :unique => true })
  end
end
