require 'twilio-ruby'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
  end

  def show
    if current_user.present? && current_user == @user
      messages = Message.where(owner_id: current_user.id, complete: false)
      @messages_count = messages.where(complete: false).count
      @messages = messages.order("id desc")
      render 'profile'
    else
      @finder = User.new
      @message = Message.new
      render 'show'
    end
    # @url = user_url(@user)

  end

  def new
    @user = User.new
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_qrcode(@user)
      session[:user_id] = @user.id
      User.email_sign_up(@user.id)
      # User.delay.email_sign_up(@user.id)
      redirect_to(@user, :success => 'Successfully created your acconut.  Here is your unique QR code to print and place on valuables!')
    else
      render :new
    end
  end

  def update
      respond_to do |format|
        if @user.update(user_params)
          flash.now[:success] = 'Details Successfully update!'
          format.js
        else
          format.js { render action: 'edit'}
        end
      end
    end

  def destroy
    @user.destroy
    redirect_to user_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :cell_number, :email, :password, :password_confirmation, :qrcode, :ip_address, :latitude, :longitude)
    end

  end



  # TODO
  # profile page - inline edit for profile box, truncate email address
  # push with workers - hirefire
  # fix printing format
  # cooler qrcodes
  # payments
  # priettier emails
  # anonymous email
  # fedex /wedeliver
  # get stickers printer - api stickermuel
  # lose a phone experiement



