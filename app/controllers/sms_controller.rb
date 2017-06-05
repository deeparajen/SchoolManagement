class SmsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def create_sms
    #@teacher = !params[:teacher_id].nil?? Teacher.where(:id => params[:teacher_id]).first : Teacher.where(:full_name => current_user.name).first
    @teacher = Teacher.where(:full_name => current_user.name).first
    @grades = current_user.role.name == "Admin" && @teacher.nil? ?  Grade.all : @teacher.grades 
    #@grades= Grade.where(:id => @teacher.grades.map(&:id))
  end
  
  def update_grade_list
    @teacher = Teacher.where(:id => params[:teacher_id]).first
    @grades = @teacher.grades
    respond_to do |format|
      format.js
    end
  end
  
  def update_sms
    @flag=false
    @teacher_id = params[:sm].has_key?("teacher_id") ? params[:sm][:teacher_id] : Teacher.where(:full_name => current_user.name).pluck("id").first
    @students = Student.where(:grade_id => params[:grade_id])
    @students.each do |student|
      @sms = Sm.create(:student_id => student.id,:teacher_id => @teacher_id,:task_date => params[:sm][:task_date],:sms_content => params[:sm][:sms_content])
      if @sms.save
        @flag=true
      else
        @flag=false
        break;
      end
    end
    respond_to do |format|
      if @flag
        flash[:success] = 'SMS send successfully'
        format.html { redirect_to sms_path }
      else
        flash[:error] =  @students.size == 0 ? "None of the students are present in the grade" : "Unable to send SMS"
        format.html { redirect_to sms_path}
      end
    end
  end
  
  def update_student_list
    @students = Student.where(:grade_id => params[:grade_id])
  end
  

end
