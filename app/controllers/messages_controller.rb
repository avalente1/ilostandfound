class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
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
      if @finder.save
        session[:user_id] = @finder.id
        @message.find_id = @finder.id
        if @message.save
          flash[:notice] = "Thank you, the owner have been notified. Now you can also use iLostAndFound"
          redirect_to user_url(current_user)
        else
        end
      else
      end
    end


  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:find_id, :owner_id, :text, :subject)
    end

    def finder_params
      params.require(:user).permit(:first_name, :last_name, :cell_number, :email, :password, :password_confirmation)

    end
end
