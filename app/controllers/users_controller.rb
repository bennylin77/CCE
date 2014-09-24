class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :verifyCode, :pwReset]

  def index
    @users = User.all.paginate(per_page: 30, page: params[:page]).order('id DESC') 
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
    flash[:title]='會員管理'
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
      flash[:title]='會員管理'
      redirect_to root_url, notice: '會員已認證或認證失敗'
    end  
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:title]='會員管理'
        format.html { redirect_to @user, notice: '編輯成功' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
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
         flash[:title]="會員管理"         
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
      flash[:title]='會員管理'    
      format.html { redirect_to users_url, notice: '刪除成功'  }
    end
  end
  
  def pwReset
    new_pw = SecureRandom.hex(5)
    @user.pw= new_pw
    @user.pw_confirmation= new_pw
    @user.save!
    System.sendResetPw(user: @user, new_pw: new_pw).deliver
    flash[:title]='會員管理'  
    redirect_to users_url, notice: '成功送出新密碼'     
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :extend, :age, :gender, :education, :id_no, :passport_no, :nationality, 
                                   :birthday, :address, :phone_no, :mobile_no, :identity,:pw , :pw_confirmation, :verified, :edm)
    end
end
