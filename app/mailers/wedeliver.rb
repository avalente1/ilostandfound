class Wedeliver < ActionMailer::Base
  default :from => 'james@paay.co'

  # send a signup email to the user, pass in the user object that contains the user's email address

  def wedeliver_email(user)
    james = "jruffer@gmail.com"
    mail( :to => james,
    :subject => 'Please call me for delivery' )
  end
end
