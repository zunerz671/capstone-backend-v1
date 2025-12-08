class LessonsController < ApplicationController
  before_action :require_admin, only: [ :create, :update, :destroy ]

  # GET /lessons
  def index
    lessons = Lesson.all
    render json: lessons.as_json(only: [ :id, :title, :body ])
  end

  # GET /lessons/:id
  def show
    lesson = Lesson.find(params[:id])
    render json: {
      id: lesson.id,
      title: lesson.title,
      body: lesson.body,
      lesson_pages: lesson.lesson_pages.order(:position).map do |page|
        {
          id: page.id,
          title: page.title,
          image_url: page.image_url,
          position: page.position
        }
      end
    }
  end

  # POST /lessons (admin)
  def create
    lesson = Lesson.new(lesson_params)

    if lesson.save
      render json: lesson, status: :created
    else
      render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/:id (admin)
  def update
    lesson = Lesson.find(params[:id])

    if lesson.update(lesson_params)
      render json: lesson
    else
      render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/:id (admin)
  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    head :no_content
  end

  private
  def lesson_params
    params.require(:lesson).permit(:title, :body)
  end
end
