class Notifier < ActionMailer::Base
  default :from => 'james@paay.co'

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(user)
    mail( :to => user.email,
    :subject => 'Thanks for signing up' )
  end

  def found_item_to_owner_email(message)
    @user = message.owner
    @finder = message.find
    mail( :to => message.owner.email,
      :subject => "Found your #{message.subject}!")
  end
end
