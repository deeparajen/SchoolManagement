class GradesController < ApplicationController
  before_action :set_grade, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: ::GradesDatatable.new(view_context) }
    end
  end



  def new
    @grade = Grade.new
    respond_to do |format|
      format.js {}
    end
  end

  def edit
    
  end

  def create
    @grade = Grade.new(grade_params)
    respond_to do |format|
      if @grade.save
        flash[:success] = "Class #{@grade.grade_name} added successfully." 
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
        flash[:success] = "Class #{@grade.grade_name} updated successfully."
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
    flash[:success] = "Class #{@grade.grade_name} deleted successfully."
    redirect_to grades_path
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
