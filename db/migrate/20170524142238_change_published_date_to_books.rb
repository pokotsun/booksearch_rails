class ChangePublishedDateToBooks < ActiveRecord::Migration[5.1]
  def up
    change_column :books, :published_date, :string
  end

  def down
    change_column :books, :published_date, :date
  end
end
