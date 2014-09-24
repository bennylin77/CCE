class DimensionsController < ApplicationController
  before_action :set_dimension, only: [:show, :edit, :update, :destroy]

  def index
    @dimensions = Dimension.all
  end

  def new
    @dimension = Dimension.new
  end

  def edit
  end

  def create
    @dimension = Dimension.new(dimension_params)

    respond_to do |format|
      if @dimension.save
        flash[:title]='課程分類'
        format.html { redirect_to dimensions_path, notice: '成功建立課程分類' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @dimension.update(dimension_params)
        flash[:title]='課程分類'
        format.html { redirect_to dimensions_path, notice: '編輯成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @dimension.destroy
    respond_to do |format|
      flash[:title]='課程分類'
      format.html { redirect_to dimensions_url, notice: '刪除成功' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dimension
      @dimension = Dimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dimension_params
      params.require(:dimension).permit(:name)
    end
end
