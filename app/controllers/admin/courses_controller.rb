class Admin::CoursesController < AdminController
  def index
    @admin_courses = Course.all
  end

  def new
    @admin_course = Course.new
  end
end
