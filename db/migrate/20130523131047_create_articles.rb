class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :default => "untitled article"
      t.text :content
      t.integer :user_id, :default => 1
      t.timestamps
    end
    add_index(:articles, :created_at )
  end
end
