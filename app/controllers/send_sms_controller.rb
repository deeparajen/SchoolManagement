class SendSmsController < ApplicationController
  before_action :authenticate_user!
  
  def create_sms
    @sms = Sm.new
  end
  
  def update_sms
    @flag = false
    params[:student][:id].each do |id|
      @sms = Sm.create(:student_id => id,:teacher_id => current_user.id,:sms_content => params[:sms_content])
      if @sms.save
        @flag = true
      end
      
    end
    respond_to do |format|
      if @flag
        format.html { redirect_to sms_path, notice: 'SMS send successfully' }
      else
        format.html { render action: "create_sms" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_student_list
    @students = Student.where(:grade_id => params[:grade_id])
   
  end
end
