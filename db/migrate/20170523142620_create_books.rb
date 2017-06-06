class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :published_date
      t.integer :page_count
      t.text :description
      t.string :image_url
      t.integer :genre_id
      t.integer :isbn, :limit => 8

      t.timestamps
    end
  end
end
