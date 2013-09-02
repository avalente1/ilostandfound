class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  def create
    @message = Message.new(message_params)
    @message.owner_id = params[:owner_id]
    @lat_lng = params[:lat_lng].split('|')
    @message.latitude = @lat_lng.first
    @message.longitude = @lat_lng.last
    if current_user.present?
      @message.find_id = current_user.id
      if @message.save
        Message.twilio_lost_item_notification(@message.id)
        # Message.delay.twilio_lost_item_notification(@message.id)
        Message.email_lost_item_notification(@message.id)
        # Message.delay.email_lost_item_notification(@message.id)
        flash[:notice] = "Thank you! The owner has been notified."
        redirect_to user_url(current_user)
      end
    else
      @finder = User.new(finder_params)
      @finder.password = @finder.first_name.downcase
      @finder.password_confirmation = @finder.first_name.downcase
      if @finder.save
        User.email_sign_up(@finder.id)
        # User.delay.email_sign_up(@finder.id)
        create_qrcode(@finder)
        session[:user_id] = @finder.id
        @message.find_id = @finder.id
        @message.save
        Message.twilio_lost_item_notification(@message.id)
        # Message.delay.twilio_lost_item_notification(@message.id)
        Message.email_lost_item_notification(@message.id)
        # Message.delay.email_lost_item_notification(@message.id)
        flash[:notice] = "Thank you! The owner has been notified. Now you can also use iLostAndFound to protect your valuables.  Thanks for paying it forward!"
        # @user.ip_address = request.ip
        # @user.save
        redirect_to user_url(current_user)
      end
    end
  end

  def update
    if current_user == @message.owner
      @page_id = params[:page_id]
      @message.complete = true
      @message.save
      @message_count = Message.where(owner_id: @message.owner.id, complete: false).count
      flash.now[:info] = 'Message marked complete'
      respond_to do |format|
          format.js
      end
    end
  end

  def show
    if current_user == @message.owner
      @page_id = params[:page_id]
      respond_to do |format|
        format.js
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
      params.require(:message).permit(:find_id, :owner_id, :text, :subject, :current, :ip_address, :longitude, :latitude)
    end
    def finder_params
      params.require(:user).permit(:first_name, :last_name, :cell_number, :email, :password, :password_confirmation, :ip_address)
    end
end
