module InterviewsHelper

  def my_interview?
    current_user.id == @user.id
  end

  def get_selected_interview
    @interviews.find { |interview| interview.approved? }
  end

  def get_select_options(selected_interview_id)
    @interviews.pluck(:start_time, :id).map { |start_time, id| [
      l(start_time, format: :long), # 面接開始時間
      :approved, # 承認状態に更新 (値だと文字列になりエラー)
      {
        # data-action に指定した path が action になる
        'data-action': user_interview_path(id: id),
        # 承認済みの面接日時を初期選択
        selected: id == selected_interview_id && start_time.future? ? true : nil,
        # 過去なら選択不可に
        disabled: start_time.past?
      }
    ]}
  end

end
