class UserMailer < ActionMailer::Base
  default from: "harsh@gmail.com"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email,  subject: 'Welcome to Vehicle Hiering System')
  end
  
  def booking_email(user)
    @user = user
    mail(to: @user.email,  subject: 'Your booking status is')    
  end
end
