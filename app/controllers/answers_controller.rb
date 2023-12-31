class AnswersController < ApplicationController
  before_action :set_question!
  before_action :set_answer!, except: :create  
  
  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@question)
      flash[:success] = "Answer created!"
    else
      @answers = @question.answers.order created_at:(:desc)
      render :"questions/show", status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      flash[:success] = "Answer updated!"
      redirect_to question_path(@question)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end
  
  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted!"
    redirect_to question_path(@question)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end

  def set_answer!
    @answer = @question.answers.find(params[:id])
  end
  

  
end