class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]


  def index
    @news = News.all.paginate(per_page: 20, page: params[:page]).order('id DESC') 
  end

  def indexManagement
    @news = News.all.paginate(per_page: 30, page: params[:page]).order('id DESC')    
  end

  def show
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

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
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
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:cce_class_id, :title, :content, :view, :cover)
    end
end
