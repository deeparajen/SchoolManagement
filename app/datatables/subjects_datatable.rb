class SubjectsDatatable
  delegate :params, :raw, :link_to,:image_tag, :number_to_currency,:edit_subject_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Subject.count,
      iTotalDisplayRecords: subjects.total_entries,
      aaData: data
    }
  end

private

  def data
    outer = []
    subjects.each_with_index do |subject,index|
      outer << [
        index + 1 + params[:iDisplayStart].to_i,
        subject.subject_name,
        link_to(image_tag('edit.png'), edit_subject_path(subject), :remote => true,  "data-target" => "#myModal"),
        link_to(image_tag('delete1.png'), subject, method: :delete, :data => {:confirm => 'Are you sure you want to delete this?'}, title: subject.subject_name),
      ]
    end
    outer
  end

  def subjects
    @subjects ||= fetch_subjects
  end

  def fetch_subjects
    subjects = Subject.all
    subjects = subjects.page(page).per_page(per_page)
    if params[:sSearch].present?
      subjects = subjects.where("subject_name like :search", search: "%#{params[:sSearch]}%")
    end
    subjects
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
