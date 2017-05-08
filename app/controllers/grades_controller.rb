class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @grades = Grade.all
  end

  def show
    
  end

  def new
    @grade = Grade.new
  end

  def edit
    
  end

  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      redirect_to @grade
    else
      render 'new'
    end
  end

  def update
  
    if @grade.update(grade_params)
      redirect_to @grade
    else
      render 'edit'
    end
  end

  def destroy
    @grade.destroy

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
