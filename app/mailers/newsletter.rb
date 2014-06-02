class Newsletter < ActionMailer::Base
  default from: "from@example.com"

  def letter(user, pin)
    @user = user
    @pins = pin
    mail(:to => @user.email, :subject => "Latest Pins from Our Users")
  end
end
