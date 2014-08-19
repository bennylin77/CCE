#encoding: UTF-8
class CceClassesController < ApplicationController
  before_action :set_cce_class, only: [:show, :edit, :update, :destroy]

  def index    
    
    if !params[:status].blank? and  params[:kind].blank?
      @cce_classes = CceClass.where("status = ?", params[:status]).paginate(per_page: 20, page: params[:page]).order('id DESC')
    elsif params[:status].blank? and !params[:kind].blank?
      @cce_classes = CceClass.where("kind = ?", params[:kind]).paginate(per_page: 20, page: params[:page]).order('id DESC')    
    elsif !params[:status].blank? and !params[:kind].blank?
      @cce_classes = CceClass.where("status = ? and kind = ?", params[:status], params[:kind]).paginate(per_page: 20, page: params[:page]).order('id DESC')        
    else
       @cce_classes = CceClass.all.paginate(per_page: 20, page: params[:page]).order('id DESC')       
    end
    
    if request.xhr?
      sleep(0.3) 
      render partial: "cce_classes/cce_class_block", collection: @cce_classes
    end  
  end
  
  def show
    if request.xhr?
      render layout: false   
    end   
  end

  def new
    @cce_class = CceClass.new
  end

  def edit
  end

  def create
    @cce_class = CceClass.new(cce_class_params)

    respond_to do |format|
      if @cce_class.save
        format.html { redirect_to @cce_class, notice: 'Cce class was successfully created.' }
        format.json { render :show, status: :created, location: @cce_class }
      else
        format.html { render :new }
        format.json { render json: @cce_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cce_class.update(cce_class_params)
        format.html { redirect_to @cce_class, notice: 'Cce class was successfully updated.' }
        format.json { render :show, status: :ok, location: @cce_class }
      else
        format.html { render :edit }
        format.json { render json: @cce_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cce_class.destroy
    respond_to do |format|
      format.html { redirect_to cce_classes_url, notice: 'Cce class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def addItem
    
    for i in 0..1000
      @cce_class = CceClass.new(title: '網路行銷與網站企劃實務班', status: GLOBAL_VAR['status_enrollment'], kind: GLOBAL_VAR['kind_credit'] )
      @cce_class.save!
    end
    
    redirect_to cce_classes_url
  end
  
  def search 
    @term=params[:search][:term]     
    @cce_classes = CceClass.where("title LIKE ?", "%#{@term}%")                                                          
    @cce_classes = @cce_classes.paginate(per_page: 30, page: params[:page]).order('id DESC')    
    render :index       
  end

  def autoComplete 
    @cce_classes_json=Array.new
    @cce_classes=CceClass.where("title LIKE ?", "%#{params[:term]}%").order('id DESC')
    @cce_classes.each do |c|
      @cce_classes_json << 
      {
        :label =>c.title,
        :value =>c.title
      }
    end  
    render :json=>@cce_classes_json.to_json     
  end
  private

    def set_cce_class
      @cce_class = CceClass.find(params[:id])
    end

    def cce_class_params
      params.require(:cce_class).permit(:title, :sub_title, :kind, :status, :introduction, :syllabus, :schedule, 
                                        :enrollment_user, :future, :location, :tuition, :lecturers, :start_at, 
                                        :end_at, :class_time, :user_size_limits, :note)
    end
end
