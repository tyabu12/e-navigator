module InterviewsHelper

  def my_interview?
    current_user.id == @user.id
  end

  def get_selected_interview
    @interviews.find { |interview| interview.approved? }
  end

end
