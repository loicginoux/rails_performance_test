# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130530132121) do

  create_table "articles", :force => true do |t|
    t.string   "title",      :default => "untitled article"
    t.text     "content"
    t.integer  "user_id",    :default => 1
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "articles", ["created_at"], :name => "index_articles_on_created_at"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id",      :default => 1
    t.boolean  "is_moderated", :default => false
    t.string   "opinion"
    t.integer  "article_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "comments", ["article_id", "created_at", "is_moderated"], :name => "index_comments_on_article_id_and_created_at_and_is_moderated"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "stats_article_comments", :force => true do |t|
    t.integer "article_id"
    t.integer "nb_com_tot",    :default => 0
    t.integer "nb_com_pos",    :default => 0
    t.integer "nb_com_neg",    :default => 0
    t.integer "nb_com_neutr",  :default => 0
    t.integer "nb_com_no_mod", :default => 0
    t.date    "day"
  end

  add_index "stats_article_comments", ["article_id", "day"], :name => "index_stats_article_comments_on_article_id_and_day"

end
