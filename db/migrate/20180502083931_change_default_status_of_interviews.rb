class ChangeDefaultStatusOfInterviews < ActiveRecord::Migration[5.1]
  def change
    change_column_default :interviews, :status, Interview.statuses[:on_hold]
  end
end
