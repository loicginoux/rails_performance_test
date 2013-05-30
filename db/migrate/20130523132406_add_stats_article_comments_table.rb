class AddStatsArticleCommentsTable < ActiveRecord::Migration
  def change
		create_table :stats_article_comments do |t|
      t.integer :article_id
      t.integer :nb_com_tot, :default => 0
      t.integer :nb_com_pos, :default => 0
      t.integer :nb_com_neg, :default => 0
      t.integer :nb_com_neutr, :default => 0
      t.integer :nb_com_no_mod, :default => 0
      t.date :day
    end
    add_index(:stats_article_comments, [:article_id, :day])
  end
end
