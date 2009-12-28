ActiveRecord::Schema.define :version => 0 do
  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "books", :force => true do |t|
    t.string    "title"
    t.integer   "author_id"
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end
end
