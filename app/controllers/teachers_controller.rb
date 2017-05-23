class TeachersController < ApplicationController
  before_action :set_teacher, only: [:edit, :update, :destroy,:update_grade]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
  def index
     respond_to do |format|
      format.html
      format.json { render json: ::TeachersDatatable.new(view_context) }
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @teacher = Teacher.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @teacher.errors.full_messages, 
                            status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @teacher.errors.full_messages,
                                   status: :unprocessable_entity }
      end
     
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def assign_class
    @teacher = !params[:teacher_id].nil?? Teacher.where(:id => params[:teacher_id]).first : Teacher.where(:full_name => current_user.name).first
    @teacher = Teacher.new if @teacher.nil?
  end
  
  def update_class_teacher
    if params[:teacher].has_key?("id")
      @teacher = Teacher.where(:id => params[:teacher][:id]).first
    else
      @teacher = Teacher.where(:full_name => current_user.name).first
    end
    @new_grades =  params[:teacher][:grade_ids].reject(&:empty?) - @teacher.grades.collect(&:id).map(&:to_s)
    @new_grades.each do |grade|
      @grade = Grade.where(:id => grade).first
      @teacher.grades << @grade
    end
    respond_to do |format|
        flash[:success] = "Class was successfully assigned to #{@teacher.full_name}."
        format.html { redirect_to assign_class_url(:teacher_id => @teacher.id)}
        format.json { head :no_content }
    end
  end
  
  def update_grade
    @grade_ids = []
    @grade_ids = @teacher.grades.collect(&:id).map(&:to_s)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:full_name,:mobile_no,:qualification,grade_ids:[])
    end
end
