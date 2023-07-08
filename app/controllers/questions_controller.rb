class QuestionsController < ApplicationController
  before_action :set_question, only: %i[edit show update destroy]

  def edit
  end
  
  def show
  end

  def update
    if @question.update question_params
      redirect_to questions_path
      flash[:success] = "Question updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @question.destroy
    redirect_to questions_path
    flash[:success] = "Question deleted!"
  end

  def index
    @questions = Question.all
  end
  def new
    @question = Question.new
  end
  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
    
  end
  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
  
  def set_question
    @question = Question.find(params[:id]) 
  end
end