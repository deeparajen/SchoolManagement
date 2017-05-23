class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /students
  # GET /students.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ::StudentsDatatable.new(view_context) }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @student.errors.full_messages, 
                            status: :unprocessable_entity }
      end
      
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @student.errors.full_messages,
                                   status: :unprocessable_entity }
      end
     
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :roll_no, :father_name, :mobile_no, :gender, :grade_id)
    end
end
