class InquiryMailer < ApplicationMailer  

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => ENV['USER_NAME'], :subject => 'お問い合わせ内容が届いています。')
  end

end
