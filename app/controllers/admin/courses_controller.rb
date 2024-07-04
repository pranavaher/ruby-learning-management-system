class Admin::CoursesController < AdminController
  def index
    @admin_courses = Course.all
  end
end
