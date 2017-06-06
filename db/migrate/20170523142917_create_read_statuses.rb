class CreateReadStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :read_statuses do |t|
      t.references :book, foreign_key: true
      t.date :begin_date
      t.date :end_date
      t.boolean :favorite
      t.integer :score
      t.text :review

      t.timestamps
    end
  end
end
