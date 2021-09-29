class InquiryController < ApplicationController
  before_action :request_valid, only: [:confirm]

  def form_top
    @inquiry = if current_user.nil?
                 Inquiry.new
               else
                 Inquiry.new(name: current_user.name, email: current_user.email)
               end
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.invalid?
      flash.now[:alert] = "入力に不備があります。再度ご確認ください。"
      render :form_top
    end
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
    InquiryMailer.thanks_email(@inquiry).deliver
    redirect_to inquiry_thanks_path
  end

  def thanks
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end

  # postメソッドページでのリロード対策
  def request_valid
    if request.method == "GET"
      flash.now[:alert] = "不正な動作がありました。再度入力してください。"
      @inquiry = Inquiry.new
      render :form_top
    end
  end
end
