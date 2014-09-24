#encoding: UTF-8
class CceClassesController < ApplicationController
  before_action :set_cce_class, only: [:show, :showManagement, :edit, :update, :destroy, :verified, :available, :signsheet]

  def index    
    if params[:dimension].blank? and params[:kind].blank? and params[:status].blank?
      @cce_classes = CceClass.where("verified = true").paginate(per_page: 30, page: params[:page]).order('id DESC')       
    elsif !params[:dimension].blank? and params[:kind].blank? and params[:status].blank?
      @cce_classes = CceClass.joins(:cce_class_dimensions).where("verified = true and cce_class_dimensions.dimension_id = ?", params[:dimension]).paginate(per_page: 30, page: params[:page]).order('id DESC')                
    elsif params[:dimension].blank? and !params[:kind].blank? and params[:status].blank?   
      @cce_classes = CceClass.where("verified = true and kind = ?", params[:kind]).paginate(per_page: 30, page: params[:page]).order('id DESC')                
    elsif params[:dimension].blank? and params[:kind].blank? and !params[:status].blank?
      @cce_classes = CceClass.where("verified = true and status = ?", params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')        
    elsif !params[:dimension].blank? and !params[:kind].blank? and params[:status].blank?
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("verified = true and cce_class_dimensions.dimension_id = ? and kind = ?", params[:dimension], params[:kind]).paginate(per_page: 30, page: params[:page]).order('id DESC')                      
    elsif params[:dimension].blank? and !params[:kind].blank? and !params[:status].blank?
      @cce_classes = CceClass.where("verified = true and kind = ? and status = ?", params[:kind], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')              
    elsif !params[:dimension].blank? and params[:kind].blank? and !params[:status].blank?    
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("verified = true and cce_class_dimensions.dimension_id = ? and status = ?", params[:dimension], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')                                          
    elsif !params[:dimension].blank? and !params[:kind].blank? and !params[:status].blank?   
       @cce_classes = CceClass.joins(:cce_class_dimensions).where("verified = true and cce_class_dimensions.dimension_id = ? and kind = ? and status = ?", params[:dimension], params[:kind], params[:status]).paginate(per_page: 30, page: params[:page]).order('id DESC')                                          
                   
    end    
 
    if request.xhr?
      sleep(0.3) 
      render partial: "cce_classes/cce_class_block", collection: @cce_classes
    end  
  end
  
  def show
    if request.xhr?
      render layout: 'fancybox'
    end   
  end
  
  def showManagement 
  end
  
  def signsheet
  end
  
  def indexManagement
    @cce_classes = CceClass.all.paginate(per_page: 30, page: params[:page]).order('id DESC')    
  end

  def new
    @cce_class = CceClass.new
    unless params[:id].blank?
      clone_cce_class= CceClass.find(params[:id])
      @cce_class.attributes = {title: clone_cce_class.title, sub_title: clone_cce_class.sub_title, kind: clone_cce_class.kind, 
                               introduction: clone_cce_class.introduction, syllabus: clone_cce_class.syllabus, schedule: clone_cce_class.schedule, 
                               enrollment_user: clone_cce_class.enrollment_user, future: clone_cce_class.future, location: clone_cce_class.location, 
                               tuition: clone_cce_class.tuition, lecturers: clone_cce_class.lecturers, class_time: clone_cce_class.class_time,
                               note: clone_cce_class.note, requester: clone_cce_class.requester, organizer: clone_cce_class.organizer, 
                               other_organizer: clone_cce_class.other_organizer, host: clone_cce_class.host, host_extend: clone_cce_class.host_extend,
                               grants: clone_cce_class.grants, total_tuition: clone_cce_class.total_tuition, other_funds: clone_cce_class.other_funds, 
                               total_credits: clone_cce_class.total_credits, total_hours: clone_cce_class.total_hours, in_school_lecturers_quantity: clone_cce_class.in_school_lecturers_quantity,
                               out_school_lecturers_quantity: clone_cce_class.out_school_lecturers_quantity, school_expenses: clone_cce_class.school_expenses, 
                               academic_expenses: clone_cce_class.academic_expenses, center_expenses: clone_cce_class.center_expenses, college_expenses: clone_cce_class.college_expenses, 
                               department_expenses: clone_cce_class.department_expenses, school_venue_fee: clone_cce_class.school_venue_fee, units_venue_fee: clone_cce_class.units_venue_fee, 
                               personnel_fee: clone_cce_class.personnel_fee, sales_fee: clone_cce_class.sales_fee, travel_fee: clone_cce_class.travel_fee, facilities_fee: clone_cce_class.facilities_fee, 
                               hourly_fee: clone_cce_class.hourly_fee }     
    end  
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
    @cce_class.user=User.find(session[:user_id])

    respond_to do |format|
      if @cce_class.save
        flash[:title]='推廣教育課程管理'
        flash[:notice]='已申請推廣教育課程, 請等待審查'
        format.html { redirect_to controller: 'cce_classes', action: 'showManagement', id: @cce_class.id }
      else
        format.html { render :new }
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
        flash[:title]='推廣教育課程管理'
        flash[:notice]='編輯成功'        
        format.html { redirect_to  controller: 'cce_classes', action: 'showManagement', id: @cce_class.id}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @cce_class.destroy
    respond_to do |format|
      flash[:title]='推廣教育課程管理'
      format.html { redirect_to cce_classes_url, notice: '刪除成功' }
    end
  end
  
  def verified
    @cce_class.verified=!@cce_class.verified
    if @cce_class.verified
      @cce_class.verified_user_id=session[:user_id]  
    else
      @cce_class.verified_user_id=nil
    end      
    @cce_class.save!
    flash[:title]='推廣教育課程管理'
    flash[:notice]='成功更改審核狀態'
    redirect_to controller: :cce_classes, action: :indexManagement
  end
  
  def available
    @cce_class.available=!@cce_class.available
    @cce_class.save! 
    redirect_to controller: :cce_classes, action: :indexManagement    
  end
  
  
  
  
  def addItem
    
    for i in 0..1000
      @cce_class = CceClass.new(title: '網路行銷與網站企劃實務班', status: GLOBAL_VAR['status_enrollment'], kind: GLOBAL_VAR['kind_training'],
                               start_at: Date.today(), end_at: Date.today(),  
                               introduction: i, syllabus: i, schedule: i, 
                               enrollment_user: i, location: i, tuition: i, 
                               user_size_limits: 1, requester: i, class_time: i,
                               organizer: i, host: i, host_extend: i, total_tuition: i,
                               total_hours: 2, in_school_lecturers_quantity: 1, out_school_lecturers_quantity: 1,
                               school_expenses: i, school_year: i, verified: true, user_id: 1 )
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
                                        :other_funds, :total_credits, :total_hours, :in_school_lecturers_quantity, :out_school_lecturers_quantity,
                                        :school_expenses, :academic_expenses, :center_expenses, :college_expenses, :department_expenses,
                                        :school_venue_fee, :units_venue_fee, :personnel_fee, :sales_fee, :travel_fee, :facilities_fee, 
                                        :hourly_fee, :link, :attachment, :registration_link)
    end
end
