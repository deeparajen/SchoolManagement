class SendSmsController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource
  
  def create_sms
    #@teacher = !params[:teacher_id].nil?? Teacher.where(:id => params[:teacher_id]).first : Teacher.where(:full_name => current_user.name).first
    @teacher = Teacher.where(:full_name => current_user.name).first
    @grades = current_user.role.name == "Admin" && @teacher.nil? ?  Grade.all : @teacher.grades 
    #@grades= Grade.where(:id => @teacher.grades.map(&:id))
  end
  
  def update_sms
    @flag=false
    @students = Student.where(:grade_id => params[:sm][:id])
    @students.each do |id|
      @sms = Sm.create(:student_id => id,:teacher_id => current_user.id,:task_date => params[:sm][:task_date],:sms_content => params[:sm][:sms_content])
      if @sms.save
        @flag=true
      else
        @flag=false
      end
    end
    respond_to do |format|
      if @flag
        flash[:success] = 'SMS send successfully'
        format.html { redirect_to sms_path }
      else
        format.html { redirect_to sms_path }
        format.json { render json: @sms.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_student_list
    @students = Student.where(:grade_id => params[:grade_id])
   
  end
end
