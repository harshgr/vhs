class UserMailer < ActionMailer::Base
  default from: "vhs@gr.com"
  
  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Vehicle Hiering System')
  end
  
  def booking_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your booking status is')
  end
  
  

end
