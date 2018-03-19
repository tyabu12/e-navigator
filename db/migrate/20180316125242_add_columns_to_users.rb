class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, default: "", null: false
    add_column :users, :birthday, :date, default: -> { 'CURRENT_DATE' } , null: false
    add_column :users, :gender, :integer, default: 0, null: false, limit: 1
    add_column :users, :school_name, :string, default: "", null: false
  end
end
