class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string "title"
      t.string "product_type"
      t.string "handle"
      t.string "template_suffix"
      t.text "body_html"
      t.string "tags"
      t.string "published_scope"
      t.jsonb "image"
      t.string "vendor"
      t.jsonb "options"
      t.datetime "published_at"
      t.timestamps
    end
  end
end