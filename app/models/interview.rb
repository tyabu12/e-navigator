class Interview < ApplicationRecord
  belongs_to :user

  enum status: { approved: 0, on_hold: 1, rejected: 2 }

  def update(attributes)
    # 承認状態を承認に変更するかで場合分け
    if attributes[:status] == 'approved' && self.status != :approved
      Interview.transaction do
        # 承認済みの面接がある場合は拒否に変更 (承認の面接は1件しかないと仮定する)
        approved_interview = Interview.find_by(status: "#{Interview.statuses[:approved]}")
        if approved_interview
          approved_interview.update_attributes!(status: Interview.statuses[:rejected])
        end
        # 対象の面接を承認に変更
        self.update!(attributes)
      end
    else
      super attributes
    end
  end

end
