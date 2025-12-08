class AssessmentsController < ApplicationController
  before_action :require_admin, only: [ :create, :update, :destroy ]

  # GET /assessments
  def index
    assessments = Assessment.includes(:lesson).all

    render json: assessments.map { |assessment|
      {
        id: assessment.id,
        title: assessment.title,
        version: assessment.version,
        lesson_id: assessment.lesson_id,
        lesson_title: assessment.lesson.title
      }
    }
  end

  # GET /assessments/:id
  def show
    assessment = Assessment.find(params[:id])

    render json: {
      id: assessment.id,
      title: assessment.title,
      version: assessment.version,
      lesson_id: assessment.lesson_id,
      questions: assessment.questions.map do |q|
        {
          id: q.id,
          title: q.title,
          image_url: q.image_url
        }
      end
    }
  end

  # POST /assessments (admin)
  def create
    assessment = Assessment.new(assessment_params)

    if assessment.save
      render json: assessment, status: :created
    else
      render json: { errors: assessment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assessments/:id (admin)
  def update
    assessment = Assessment.find(params[:id])

    if assessment.update(assessment_params)
      render json: assessment
    else
      render json: { errors: assessment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /assessments/:id (admin)
  def destroy
    assessment = Assessment.find(params[:id])
    assessment.destroy
    head :no_content
  end

  # POST /assessments/:id/submit (student or admin)
  def submit
    assessment = Assessment.includes(:questions).find(params[:id])
    responses_param = submit_params[:responses] || []

    attempt = AssessmentAttempt.create!(
      user: current_user,
      assessment: assessment
    )

    correct_count = 0
    details = []

    assessment.questions.each do |question|
      # Find the matching response for this question (if any)
      response_entry = responses_param.find do |r|
        r[:question_id].to_i == question.id
      end

      response_text = response_entry ? response_entry[:response].to_s : ""
      is_correct = response_text.strip == question.correct_answer.strip
      correct_count += 1 if is_correct

      QuestionResponse.create!(
        user: current_user,
        question: question,
        assessment_attempt: attempt,
        response: response_text,
        correct: is_correct
      )

      details << {
        question_id: question.id,
       response: response_text,
        correct_answer: question.correct_answer,
        correct: is_correct
      }
    end

    attempt.update!(
      score: correct_count,
      completed_at: Time.current
    )

    render json: {
      attempt_id: attempt.id,
      correct_count: correct_count,
      total: assessment.questions.count,
      details: details
      }, status: :created
    end

  private
  def assessment_params
    params.require(:assessment).permit(:title, :version, :lesson_id)
  end

  def submit_params
    params.permit(responses: [ :question_id, :response ])
  end
end
