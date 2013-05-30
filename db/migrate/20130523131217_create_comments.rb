class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id, :default => 1
      t.boolean :is_moderated, :default => false
      t.string :opinion
      t.integer :article_id
      t.timestamps
    end

    add_index(:comments, [:article_id, :created_at, :is_moderated] )

  end
end
