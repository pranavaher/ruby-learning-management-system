class Admin::CoursesController < AdminController
  def index
    @admin_courses = Course.all
  end

  def new
    @admin_course = Course.new
  end

  def show
    @admin_course = Course.find(params[:id])
  end

  def create
    @admin_course = Course.new(admin_course_params)

    if @admin_course.save
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  def edit
    @admin_course = Course.find(params[:id])    
  end

  def update
    @admin_course = Course.find(params[:id])

    if @admin_course.update(admin_course_params)
      redirect_to admin_courses_path
    else
      render :edit
    end
  end

  private

  def admin_course_params
    params.require(:course).permit(:title, :description, :paid, :stripe_price_id, :premium_description, :image)
  end
end
