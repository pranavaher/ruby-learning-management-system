class Admin::LessonsController < AdminController
  before_action :set_course
  before_action :set_lesson, only: [:move, :show, :edit, :update, :destroy]

  def index
    @admin_lessons = @admin_course.lessons.order(:position)
  end

  def new
    @admin_lesson = @admin_course.lessons.new
  end

  def create
    @admin_lesson = @admin_course.lessons.new(lesson_params)

    if @admin_lesson.save
      redirect_to admin_course_lessons_path(@admin_course), notice: "Lesson was successfully created."
    else
      render :new
    end
  end

  def show
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

  def edit
  end

  def update
    if @admin_lesson.update(lesson_params)
      redirect_to admin_course_lessons_path(@admin_course), notice: "Lesson was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @admin_lesson.destroy
      redirect_to admin_course_lessons_path(@admin_course), notice: "Lesson was successfully deleted."
    else
      redirect_to admin_course_lessons_path(@admin_course), alert: "Lesson was not deleted."
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :description, :video, :paid, :position)
  end

  def set_course
    @admin_course = Course.find(params[:course_id])
  end

  def set_lesson
    @admin_lesson = @admin_course.lessons.find(params[:id])
  end
end
