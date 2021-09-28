class InquiryMailer < ApplicationMailer
  default from: '管理者 <example@gmail.com>' # 送信元アドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:to => ENV['SEND_MAIL'], :subject => "【share-kaji】お問い合わせ通知")
  end

  def thanks_email(inquiry)
    @inquiry = inquiry
    email_with_name = %("#{inquiry.name}" <#{inquiry.email}>)
    mail(:to => email_with_name, :subject => "【share-kaji】お問い合わせを受け付けしました。")
  end
end
