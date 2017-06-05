class GradesController < ApplicationController
  before_action :set_grade, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  load_and_authorize_resource
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: ::GradesDatatable.new(view_context) }
    end
  end



  def new
  end

  def edit
    
  end

  def create
    @grade = Grade.new(grade_params)
    respond_to do |format|
      if @grade.save
        flash.now[:success] = "Grade '#{@grade.grade_name}' added successfully." 
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @grade.errors.full_messages, 
                            status: :unprocessable_entity }
      end
      
    end
    
  end

  def update
      
    respond_to do |format|
      if @grade.update(grade_params)
        flash.now[:success] = "Grade '#{@grade.grade_name}' updated successfully."
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @grade.errors.full_messages,
                                   status: :unprocessable_entity }
      end
     
    end
  end

  def destroy
    @grade.destroy
    respond_to do |format|
      flash[:success] = "Grade '#{@grade.grade_name}' deleted successfully."
      format.html { redirect_to grades_path }
      format.json { head :no_content }
    end
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

  private
  def grade_params
    params.require(:grade).permit(:grade_name)
  end

end
