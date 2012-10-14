class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :oid, :unique => true
      t.string :title
      t.references :user
      t.references :page

      t.timestamps
    end
    add_index :commits, :user_id
    add_index :commits, :page_id
    add_index :commits, :oid
  end
end
