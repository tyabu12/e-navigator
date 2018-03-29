module InterviewsHelper

  def get_selected_interview
    @interviews.find { |interview| interview.approved? }
  end

end
