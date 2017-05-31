class GradesDatatable
  delegate :params, :raw, :link_to,:image_tag, :number_to_currency,:edit_grade_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Grade.count,
      iTotalDisplayRecords: grades.total_entries,
      aaData: data
    }
  end

private

  def data
    outer = []
    grades.each_with_index do |grade,index|
     outer << [
        index + 1 + params[:start].to_i,
        grade.grade_name,
        link_to(image_tag('edit.png'), edit_grade_path(grade), :remote => true,  "data-target" => "#myModal",title: "Edit"),
        link_to(image_tag('delete1.png'), grade, method: :delete, confirm: "You sure?", title: grade.grade_name),
      ]
    end
    outer
  end

  def grades
    @grades ||= fetch_grades
  end

  def fetch_grades
    grades = Grade.all
    grades = grades.page(page).per_page(per_page)
    if params[:sSearch].present?
      grades = grades.where("grade_name like :search", search: "%#{params[:sSearch]}%")
    end
    grades
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[grade_name]
    columns[params[:iSortCol_0].to_i]
  end
  
  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
