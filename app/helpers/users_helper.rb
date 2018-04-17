module UsersHelper
  
  def get_approved_interview_start_time user
    interview = Interview.find_by user_id: user.id, status: Interview.statuses[:approved]
    interview ? interview.start_time : nil
  end

  def other_users
    User.all_except(current_user)
  end

end
