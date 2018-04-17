class NotifierMailer < ApplicationMailer

  def interview_was_finalized(current_user, interview_user, interview)
    @current_user = current_user
    @interview_user = interview_user
    @interview = interview
    mail(
      to: [current_user.email_with_name, interview_user.email_with_name],
      subject: '面接日時が確定しました'
    )
  end

end
