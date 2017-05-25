class StudentsDatatable
  delegate :params, :raw, :link_to,:image_tag, :number_to_currency,:edit_student_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Student.count,
      iTotalDisplayRecords: students.total_entries,
      aaData: data
    }
  end

private

  def data
    students.map do |student|
      [
        student.name,
        student.roll_no,
        student.grade.grade_name,
        student.father_name,
        student.mobile_no,
        student.gender,
        link_to(image_tag('edit.png'), edit_student_path(student), :remote => true,  "data-target" => "#myModal"),
        link_to(image_tag('delete1.png'), student, method: :delete, confirm: "You sure?", title: student.name),
      ]
    end
  end

  def students
    @students ||= fetch_students
  end

  def fetch_students
    students = Student.joins(:grade)
    students = students.page(page).per_page(per_page)
    if params[:sSearch].present?
      students = students.where("name like :search or roll_no like :search or father_name like :search or grade_name like :search or mobile_no like :search or gender like :search", search: "%#{params[:sSearch]}%")
    end
    students
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
