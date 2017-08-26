class SendEmailMailer < ApplicationMailer

  def welcome(user)
    @user = user 

    mail(to: user.email, subject: "Welcome to online digital market")
  end
end
