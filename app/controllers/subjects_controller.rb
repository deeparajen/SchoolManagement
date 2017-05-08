class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @subjects = Subject.all
  end

  def show
    
  end

  def new
    @subject = Subject.new
  end

  def edit
    
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to @subject
    else
      render 'new'
    end
  end

  def update
  
    if @subject.update(subject_params)
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def destroy
    @subject.destroy

    redirect_to subjects_path
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
