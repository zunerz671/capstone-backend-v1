class LessonPagesController < ApplicationController
  before_action :set_lesson

  # POST /lessons/:lesson_id/lesson_pages (admin)
  def create
    page = @lesson.lesson_pages.new(lesson_page_params)

    if page.save
      render json: page, status: :created
    else
      render json: { errors: page.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/:lesson_id/lesson_pages/:id (admin)
  def update
    page = @lesson.lesson_pages.find(params[:id])

    if page.update(lesson_page_params)
      render json: page
    else
      render json: { errors: page.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/:lesson_id/lesson_pages/:id (admin)
  def destroy
    page = @lesson.lesson_pages.find(params[:id])
    page.destroy
    head :no_content
  end

  private
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def lesson_page_params
    params.require(:lesson_page).permit(:title, :image_url, :position)
  end
end
