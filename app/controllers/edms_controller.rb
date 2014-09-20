class EdmsController < ApplicationController
  before_action :set_edm, only: [:show]

  def index
    @edms = Edm.all.paginate(per_page: 30, page: params[:page]).order('id DESC') 
  end

  def show
  end

  def new
    @edm = Edm.new
  end

  def create
    @edm = Edm.new(edm_params)
    params[:edm][:news_ids].each do |n|
      unless n.blank?
        @edm.news<<News.find(n)
      end
    end
    @edm.user=User.find(session[:user_id])
    
    respond_to do |format|
      if @edm.save
        System.sendEDM(edm: @edm).deliver
        format.html { redirect_to @edm, notice: 'Edm was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edm
      @edm = Edm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edm_params
      params.require(:edm).permit(:title, :user_id)
    end
end
