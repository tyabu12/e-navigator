class Interview < ApplicationRecord
  belongs_to :user

  enum status: { approved: 0, on_hold: 1, rejected: 2 }

  validate :valid_start_time?

  # 承認状態削除は拒否
  before_destroy :status_should_not_be_approved

  def update(attributes)
    # 承認状態を承認に変更するかで場合分け
    if attributes[:status] == 'approved' && self.status != 'approved'
      Interview.transaction do
        # 承認済みの面接がある場合は拒否に変更 (承認の面接は1件しかないと仮定する)
        approved_interview = Interview.find_by(
          user_id: user_id,
          status: "#{Interview.statuses[:approved]}"
        )
        if approved_interview
          approved_interview.update_attribute(:status, Interview.statuses[:rejected])
        end
        # 対象の面接を承認に変更
        self.update!(attributes)
      end
    else
      # 承認状態の更新は拒否
      status_should_not_be_approved
      super attributes
    end
  rescue StandardError
    false
  end

  private

  def valid_start_time?
    errors.add(:start_time, :cannot_be_past) unless start_time.future?
  end

  def status_should_not_be_approved
    return true unless self.approved?

    errors.add(:status, :should_not_be_accepted)
    throw :abort
  end

end
