module ComplaintsHelper
  def display_status_for(complaint, field)
     (@complaint.errors[field] || []).join( " " )
  end
end
