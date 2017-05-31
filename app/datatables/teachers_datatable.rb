class TeachersDatatable
  delegate :params, :raw, :link_to,:image_tag, :number_to_currency,:edit_teacher_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Teacher.count,
      iTotalDisplayRecords: teachers.total_entries,
      aaData: data
    }
  end

private

  def data
    outer = []
    teachers.each_with_index do |teacher,index|
      outer << [
        index + 1 + params[:start].to_i,
        teacher.full_name,
        teacher.qualification,
        teacher.mobile_no,
        link_to(image_tag('edit.png'), edit_teacher_path(teacher), :remote => true,  "data-target" => "#myModal"),
        link_to(image_tag('delete1.png'), teacher, method: :delete, confirm: "You sure?", title: teacher.full_name),
      ]
    end
    outer
  end

  def teachers
    @teachers ||= fetch_teachers
  end

  def fetch_teachers
    teachers = Teacher.all
    teachers = teachers.page(page).per_page(per_page)
    if params[:sSearch].present?
      teachers = teachers.where("full_name like :search or qualification like :search or mobile_no like :search", search: "%#{params[:sSearch]}%")
    end
    teachers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  
  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
