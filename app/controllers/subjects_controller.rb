class SubjectsController < ApplicationController
  before_action :set_subject, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: ::SubjectsDatatable.new(view_context) }
    end
  end

  def new
    @subject = Subject.new
    respond_to do |format|
      format.js {}
    end
  end

  def edit
    
  end

  def create
    @subject = Subject.new(subject_params)

   respond_to do |format|
      if @subject.save
        flash[:success] = "Subject '#{@subject.subject_name}' added successfully." 
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @subject.errors.full_messages, 
                            status: :unprocessable_entity }
      end
      
    end
  end

  def update
  
    respond_to do |format|
      if @subject.update(subject_params)
        flash[:success] = "Subject '#{@subject.subject_name}' updated successfully."
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @subject.errors.full_messages,
                                   status: :unprocessable_entity }
      end
     
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      flash[:success] = "Subject '#{@subject.subject_name}' deleted successfully."
      format.html { redirect_to subjects_path }
      format.json { head :no_content }
    end
    
    
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

  private
  def subject_params
    params.require(:subject).permit(:subject_name)
  end

end
