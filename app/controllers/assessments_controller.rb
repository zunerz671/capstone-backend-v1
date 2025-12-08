class AssessmentsController < ApplicationController
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

  private
  def assessment_params
    params.require(:assessment).permit(:title, :version, :lesson_id)
  end
end
