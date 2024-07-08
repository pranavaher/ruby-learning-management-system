class Admin::LessonsController < AdminController
  before_action :set_course
  before_action :set_lesson, only: [:move]

  def index
    @admin_lessons = @admin_course.lessons.order(:position)
  end

  def move
    position = params[:position].to_i
    if position == 0
      @admin_lesson.move_to_top
    elsif position == @admin_course.lessons.count - 1
      @admin_lesson.move_to_bottom
    else
      @admin_lesson.insert_at(position + 1)
    end
    @admin_lesson.save!

    render json: { message: "success" } 
  end

  private

  def set_course
    @admin_course = Course.find(params[:course_id])
  end

  def set_lesson
    @admin_lesson = @admin_course.lessons.find(params[:id])
  end
end
