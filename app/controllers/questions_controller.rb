class QuestionsController < ApplicationController
  before_action :set_assessment
  before_action :require_admin

  # POST /assessments/:assessment_id/questions (admin)
  def create
    question = @assessment.questions.new(question_params)
    question.lesson_id = @assessment.lesson_id

    if question.save
      render json: question, status: :created
    else
      render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assessments/:assessment_id/questions/:id (admin)
  def update
    question = @assessment.questions.find(params[:id])

    if question.update(question_params)
      render json: question
    else
      render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /assessments/:assessment_id/questions/:id (admin)
  def destroy
    question = @assessment.questions.find(params[:id])
    question.destroy
    head :no_content
  end

  private
  def set_assessment
    @assessment = Assessment.find(params[:assessment_id])
  end

  def question_params
    params.require(:question).permit(:title, :image_url, :correct_answer)
  end
end
