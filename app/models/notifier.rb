class Notifier < ActionMailer::Base
  # include SendGrid

  default :from => 'james@paay.co'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(messgae)
    @user = message.user
    @finder = message.find
    mail( :to => message.user.email,
    :subject => "Found your #{@message.subject}!" )
  end

  # def found_item_to_owner_email(message)
  #   @user = message.user
  #   @finder = message.find
  #   mail( :to => message.user.email,
  #     :subject => "Found your #{@message.subject}!")
  # end


end
