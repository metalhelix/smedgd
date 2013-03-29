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

ActiveRecord::Schema.define(:version => 20130329163033) do

  create_table "features", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "location_id"
    t.string   "link"
    t.integer  "genome_id"
    t.string   "slug"
    t.string   "standard_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "features", ["slug"], :name => "index_features_on_slug", :unique => true

  create_table "genomes", :force => true do |t|
    t.string   "organism"
    t.string   "version"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
    t.string   "key"
  end

  add_index "genomes", ["slug"], :name => "index_genomes_on_slug", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "sequence_name"
    t.string   "sequence_type"
    t.integer  "start"
    t.integer  "stop"
    t.integer  "strand"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "transcripts", :force => true do |t|
    t.integer  "location_id"
    t.integer  "gene_id"
    t.text     "sequence_aa"
    t.text     "sequence_nuc"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug"
  end

  add_index "transcripts", ["slug"], :name => "index_transcripts_on_slug", :unique => true

end
