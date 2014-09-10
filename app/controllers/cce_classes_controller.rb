#encoding: UTF-8
class CceClassesController < ApplicationController
  before_action :set_cce_class, only: [:show, :edit, :update, :destroy, :verified, :available]

  def index    
    if params[:dimension].blank? and params[:kind].blank? and params[:status].blank?
      @cce_classes = CceClass.all.paginate(per_page: 30, page: params[:page]).order('id DESC')       
    elsif !params[:dimension].blank? and params[:kind].blank? and params[:status].blank?
      @cce_classes = CceClass.joins(:cce_class_dimensions).where("cce_class_dimensions.dimension_id = ?", params[:dimension]).paginate(per_page: 30, page: params[:page]).order('id DESC')                
    elsif params[:dimension].blank? and !params[:kind].blank? and params[:status].blank?   
      @cce_classes = CceClass.where("kind = ?", params[:kind]).paginate(per_page: 30, page: params[:page]).order('id DESC')                
    elsif params[:dimension].blank? and params[:kind].blank? and !params[:status].blank?
      @cce_classes = CceClass.where("status = ?", params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')        
    elsif !params[:dimension].blank? and !params[:kind].blank? and params[:status].blank?
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("cce_class_dimensions.dimension_id = ? and kind = ?", params[:dimension], params[:kind]).paginate(per_page: 30, page: params[:page]).order('id DESC')                      
    elsif params[:dimension].blank? and !params[:kind].blank? and !params[:status].blank?
      @cce_classes = CceClass.where("kind = ? and status = ?", params[:kind], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')              
    elsif !params[:dimension].blank? and params[:kind].blank? and !params[:status].blank?    
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("cce_class_dimensions.dimension_id = ? and status = ?", params[:dimension], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')                                          
    elsif !params[:dimension].blank? and !params[:kind].blank? and !params[:status].blank?   
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("cce_class_dimensions.dimension_id = ? and kind = ? and status = ?", params[:dimension], params[:kind], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')                                          
                   
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
  
  def indexManagement
    @cce_classes = CceClass.all.paginate(per_page: 30, page: params[:page]).order('id DESC')    
  end

  def new
    @cce_class = CceClass.new
  end

  def edit
  end

  def create
    @cce_class = CceClass.new(cce_class_params)
    params[:cce_class][:dimension_ids].each do |d|
      unless d.blank?
        @cce_class.dimensions<<Dimension.find(d)
      end
    end


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
    @cce_class.cce_class_dimensions.clear
    params[:cce_class][:dimension_ids].each do |d|
      unless d.blank?
        @cce_class.dimensions<<Dimension.find(d)
      end
    end    
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
  
  def verified
    @cce_class.verified=!@cce_class.verified
    @cce_class.verified_user_id=session[:user_id]    
    @cce_class.save!
    redirect_to controller: :cce_classes, action: :indexManagement
  end
  
  def available
    @cce_class.available=!@cce_class.available
    @cce_class.save! 
    redirect_to controller: :cce_classes, action: :indexManagement    
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
        label: c.title,
        value: c.title
      }
    end  
    render json: @cce_classes_json.to_json     
  end
  private

    def set_cce_class
      @cce_class = CceClass.find(params[:id])
    end

    def cce_class_params
      params.require(:cce_class).permit(:title, :sub_title, :kind, :status, :introduction, :syllabus, :schedule, 
                                        :enrollment_user, :future, :location, :tuition, :lecturers, :start_at, 
                                        :end_at, :class_time, :user_size_limits, :note, :school_year, :requester,
                                        :organizer, :other_organizer, :host, :host_extend, :grants, :total_tuition,
                                        :other_funds, :total_credits, :total_hours, :in_school_lecturers_no, :out_school_lecturers_no,
                                        :school_expenses, :academic_expenses, :center_expenses, :college_expenses, :department_expenses,
                                        :school_venue_fee, :units_venue_fee)
    end
end
