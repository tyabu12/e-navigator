class Interview < ApplicationRecord
  belongs_to :user

  enum status: { approved: 0, on_hold: 1, rejected: 2 }

  validate :valid_start_time?

  # 承認状態削除は拒否
  before_destroy :status_should_not_be_approved

  def update(attributes)
    # 承認状態を承認に変更するかで場合分け
    if attributes[:status] == 'approved' && !self.approved?
      Interview.transaction do
        # 対象の面接以外を却下に変更
        Interview.where('user_id = ? AND id <> ? AND status <> ?',
                        user_id, id, Interview.statuses[:rejected])
                 .update_all(status: Interview.statuses[:rejected])

        # 対象の面接を承認に変更
        update!(attributes)
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
