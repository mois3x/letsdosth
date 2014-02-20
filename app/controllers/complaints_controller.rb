class ComplaintsController < ApplicationController
  def index
    @complaints = Complaint.all
  end

  def new
    @complaint = Complaint.new
  end

  def create
    @complaint = Complaint.new( params[:complaint] )
    @complaint.author = current_user
    if ( @complaint.save )
      redirect_to complaints_path
    else
      render :new
    end
  end

  def edit
    @complaint = Complaint.find( params[:id] )
  end

  def update
    @complaint = Complaint.find(params[:id])

    if @complaint.update_attributes( params[:complaint] )
      redirect_to complaints_path
    else
      render :edit
    end
  end
end
