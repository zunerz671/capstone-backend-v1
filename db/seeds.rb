# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding database..."

# -------------------------
# LESSON 1
# -------------------------
lesson = Lesson.create!(
  title: "Lesson 1 - Addition Basics",
  body: "Introduction to simple addition with small numbers."
)

puts "Created Lesson ##{lesson.id}: #{lesson.title}"

# Optional: Add lesson pages (update image paths as needed)
LessonPage.create!([
  {
    lesson: lesson,
    title: "Page 1",
    image_url: "/lesson_images/lesson1_addition_page1.png",
    position: 1
  },
  {
    lesson: lesson,
    title: "Page 2",
    image_url: "/lesson_images/lesson1_addition_page2.png",
    position: 2
  },
  {
    lesson: lesson,
    title: "Page 3",
    image_url: "/lesson_images/lesson1_addition_page3.png",
    position: 3
  }
])

puts "Added lesson pages."


# -------------------------
# ASSESSMENT 1
# -------------------------
assessment = Assessment.create!(
  title: "Assessment 1 - Addition Basics",
  version: 1,
  lesson: lesson
)

puts "Created Assessment ##{assessment.id}: #{assessment.title}"


# -------------------------
# QUESTIONS (Q1–Q3)
# -------------------------
questions_data = [
  {
    title: "Q1",
    image_url: "/question_images/assessment1_addition_q1.png",
    correct_answer: "2"   # e.g., 1 + 1
  },
  {
    title: "Q2",
    image_url: "/question_images/assessment1_addition_q2.png",
    correct_answer: "4"   # e.g., 2 + 2
  },
  {
    title: "Q3",
    image_url: "/question_images/assessment1_addition_q3.png",
    correct_answer: "6"   # e.g., 3 + 3
  }
]

questions_data.each do |q|
  question = Question.create!(
    title: q[:title],
    image_url: q[:image_url],
    correct_answer: q[:correct_answer],
    assessment: assessment,
    lesson: lesson
  )
  puts "Created Question ##{question.id}: #{question.title}"
end

puts "Seeding complete!"
