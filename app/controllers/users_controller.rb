require 'rqrcode'
require 'crack/xml'
require 'open-uri'
require 'nokogiri'
require 'cobravsmongoose'
require 'curb'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def home
  end

  def print
    @size = params[:size]
  end
  # def index
  #   @users = User.all
  # end

  # GET /users/1
  # GET /users/1.json
  def show
    @qr = RQRCode::QRCode.new(user_url(@user))
  end
def test
    app_id = "OWE5NDg1YzM0NTk3NDczNGM0NzQ1ZGM5N2ZkNzQzNWNj"
    xml = Curl::Easy.perform("https://www.delivery.com/api/api.php?key=OWE5NDg1YzM0NTk3NDczNGM0NzQ1ZGM5N2ZkNzQzNWNj&method=delivery&street=1019%20W%20jackson%20blvd&zip=60607")
    #current_user.delivery_options = xml.body_str
    hash = Hash.from_xml(xml.parsed_response.gsub("\n", ""))
    current_user.delivery_options = CobraVsMongoose.xml_to_json(xml)
    current_user.save

    redirect_to user_url(current_user.id)
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
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
    def delivery

    end
end
