class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :verifyCode]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.verify_code=SecureRandom.hex(5)
    @user.save!
    System.sendVerification(user: @user).deliver
    redirect_to root_url, notice: '成功送出會員邀請函'
  rescue ActiveRecord::RecordInvalid
    @user.valid?
    render action: 'new'    
  end

  def verifyCode
    if @user.verify_code==params[:verify_code]&&!@user.verified
      session[:user_id]=@user.id
      @user.verified = true
      render action: 'edit'   
    else
      redirect_to root_url, notice: '會員已認證或認證失敗'
    end  
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def signIn
   session[:user_id]=nil
   if request.post?
      user=User.authenticate(params[:email], params[:password])
       if user
         session[:user_id]=user.id
         #uri=session[:original_uri]
         #session[:original_uri]=nil
         redirect_to root_url
       else
         flash[:title]="登入"         
         flash[:notice]="錯誤的Email或密碼"
         redirect_to root_url
       end
    end
  end

  def logOut
    session[:user_id]=nil
    redirect_to root_url
  end   


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:name, :email, :extend, :age, :gender, :education, :id_no, :passport_no, :nationality, 
                                   :birthday, :address, :phone_no, :mobile_no, :identity,:pw , :pw_confirmation, :verified)
    end
end
