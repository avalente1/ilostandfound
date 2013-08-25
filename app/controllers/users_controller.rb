require 'rqrcode'
require 'open-uri'
require 'twilio-ruby'
require 'rqrcode_png'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
  end

  def find
    @owner = User.find_by(id: params[:qr_id])
    redirect_to user_url(@owner)
  end

  def print
    @size = params[:size]
  end

  def show
    @url = user_url(@user)
    @finder = User.new
    @message = Message.new
    if current_user.present?
      @messages = Message.where(owner_id: current_user.id)
    end
    @user.ip_address = request.location
    @user.save
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

      client.account.sms.messages.create(
        from: TWILIO_CONFIG['from'],
        to: @user.cell_number,
        body: "Thanks for signing up. To verify your account, please reply HELLO to this message."
      )
      Notifier.signup_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      end
    end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :cell_show, :cell_number, :email, :email_show, :home_phone_show, :home_phone, :password, :password_confirmation, :address1, :address2, :city, :state, :postal, :qrcode)
    end

  end
