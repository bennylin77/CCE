class NewsController < ApplicationController
  before_action :set_news, only: [:verified, :show, :edit, :update, :destroy]


  def index
    @news = News.where('verified = true').paginate(per_page: 8, page: params[:page]).order('id DESC') 
  end

  def indexManagement
    @news = News.all.paginate(per_page: 30, page: params[:page]).order('id DESC')    
  end

  def show  
    @news.view=@news.view+1
    @news.save!          
    if request.xhr?     
      render layout: 'fancybox'
    end     
  end

  def new
    @news = News.new
  end

  def edit
  end

  def create
    @news = News.new(news_params)
    @news.user=User.find(session[:user_id])
    respond_to do |format|
      if @news.save
        flash[:title]='消息公告'
        format.html { redirect_to @news, notice: '成功申請刊登最新消息' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        flash[:title]='消息公告'
        format.html { redirect_to @news, notice: '編輯成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |format|
      flash[:title]='消息公告'
      format.html { redirect_to news_index_url, notice: '刪除成功' }
    end
  end
  
  def search 
    @term=params[:search][:term]     
    @news = News.where("title LIKE ?", "%#{@term}%").paginate(per_page: 15, page: params[:page]).order('id DESC')                                                              
    render :index       
  end

  def autoComplete 
    @news_json=Array.new
    @news=News.where("title LIKE ?", "%#{params[:term]}%").order('id DESC')
    @news.each do |c|
      @news_json << 
      {
        label: c.title,
        value: c.title
      }
    end  
    render json: @news_json.to_json     
  end
  
  def verified
    @news.verified=!@news.verified
    if @news.verified
      @news.verified_user_id=session[:user_id]  
    else
      @news.verified_user_id=nil
    end      
    @news.save!
    flash[:title]='消息公告'
    flash[:notice]='成功更改審核狀態'
    redirect_to controller: :news, action: :indexManagement
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:cce_class_id, :title, :content, :view, :cover, :link, :DM)
    end
end
