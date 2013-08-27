class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.owner_id = params[:owner_id]
    if current_user.present?
      @message.find_id = current_user.id
      if @message.save
        flash[:notice] = "Thank you, the owner have been notified. Now you can also use iLostAndFound"
        redirect_to user_url(current_user)
      end
    else
      @finder = User.new(finder_params)
      @finder.password = @finder.first_name.downcase
      @finder.password_confirmation = @finder.first_name.downcase
      if @finder.save
        create_qrcode(@finder)
        session[:user_id] = @finder.id
        @message.find_id = @finder.id
        if @message.save
          client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
          client.account.sms.messages.create(
          from: TWILIO_CONFIG['from'],
          to: User.find_by(id: @message.owner_id).cell_number,
          body: "Someone has found your #{@message.subject}")
          Wedeliver.wedeliver_email(@user).deliver
          flash[:notice] = "Thank you, the owner have been notified. Now you can also use iLostAndFound"
          redirect_to user_url(current_user)
        else
        end
      else
      end
    end
  end

  def destroy
    @message.destroy
      redirect_to messages_url
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end
    def message_params
      params.require(:message).permit(:find_id, :owner_id, :text, :subject)
    end
    def finder_params
      params.require(:user).permit(:first_name, :last_name, :cell_number, :email, :password, :password_confirmation, :ip_address)
    end
end
