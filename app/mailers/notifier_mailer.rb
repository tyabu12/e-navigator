class NotifierMailer < ApplicationMailer

  def interview_apply(current_user, interview_user)
    @current_user = current_user
    @interview_user = interview_user
    mail(
      to: interview_user.email_with_name,
      subject: '面接希望日時が決まりました'
    )
  end

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
