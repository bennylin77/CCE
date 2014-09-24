class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @course.cce_class_id = params[:cce_class_id]
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:title]='子課程' 
      flash[:notice]='成功建立子課程'
      redirect_to controller: :cce_classes, action: :indexManagement
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        flash[:title]='子課程'
        flash[:notice]='編輯成功'
        format.html { redirect_to controller: :cce_classes, action: :indexManagement}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      flash[:title]='子課程'
      flash[:notice]='成功刪除'      
      format.html { redirect_to controller: :cce_classes, action: :indexManagement}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:cce_class_id, :title)
    end
end
