require 'rqrcode'
<<<<<<< HEAD
require 'open-uri'
require 'twilio-ruby'
=======
require 'rqrcode_png'
>>>>>>> 994819abb316c1f66c2b8a5ee742da2f1fe2f502

class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
  end

  def find
    redirect_to user_url(params[:qr_id])
  end

  def print
    @size = params[:size]
  end

  # def index
  #   @users = User.all
  # end

  def show
<<<<<<< HEAD
    @qr = RQRCode::QRCode.new(user_url(@user))
=======
    @finder = User.new
    @message = Message.new
>>>>>>> 994819abb316c1f66c2b8a5ee742da2f1fe2f502
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
<<<<<<< HEAD
def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render text: "Thank you! You will receive an SMS shortly with verification instructions."

      # Instantiate a Twilio client
      client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

      # Create and send an SMS message
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
=======
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end


>>>>>>> 994819abb316c1f66c2b8a5ee742da2f1fe2f502
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json

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

  # DELETE /users/1
  # DELETE /users/1.json

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

    def makecall
    if !params[:cell_number]
      redirect_to :action => '.', 'msg' => 'Invalid phone number'
      return
    end

    # parameters sent to Twilio REST API
    data = {
      :from => CALLER_ID,
      :to => params[:cell_number],
      :url => BASE_URL + '/show',
    }

    begin
      client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      client.account.calls.create data
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end

    redirect_to :action => '', 'msg' => "Calling #{params['number']}..."
  end
  end
