class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.datetime :start_time, default: -> { 'NOW()' } , null: false
      t.integer :status, default: Interview.statuses[:rejected], null: false, limit: 1
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
