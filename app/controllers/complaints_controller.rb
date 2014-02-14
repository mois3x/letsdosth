class ComplaintsController < ApplicationController
  def index
    @complaints = Complaint.all
  end
end
