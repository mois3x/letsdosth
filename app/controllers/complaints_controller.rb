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

    verify_existence
    verify_authorship

  end

  def update
    @complaint = Complaint.find(params[:id])

    verify_existence
    verify_authorship
    
    update_status = @complaint.update_attributes( params[:complaint] )
    puts "UPDATE STATUS: #{update_status} - #{params} #: #{@complaint}"
    if @complaint.update_attributes( params[:complaint] )
      redirect_to complaints_path
    else
      render :edit
    end
  end

private
  def verify_authorship
    head :forbidden unless @complaint and @complaint.written_by?( current_user )
  end
  
  def verify_existence
    head(:not_found) unless @complaint
  end
  
end
