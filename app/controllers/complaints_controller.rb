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

    if @complaint.nil?
      return head(:not_found) unless @complaint
    else
      return head(:forbidden) unless @complaint.written_by?( current_user )
    end

  end

  def update
    @complaint = Complaint.find(params[:id])

    if @complaint.nil?
      return head(:not_found) unless @complaint
    else
      return head(:forbidden) unless @complaint.written_by?( current_user )
    end
    
    if @complaint.update_attributes( params[:complaint] )
      redirect_to complaints_path
    else
      render :edit
    end
  end

  # TODO
  #
  # user_id should be current user forbidden
  # if complaint doesn't exist not_found
  #
  def advocated_by
    complaint = Complaint.find_by_id(params[:id])
    user = User.find_by_id( params[:user_id] )
    
    unless complaint and user
      return head(:bad_request)
    end

    # Preventing user advocates on behalf of another one
    unless current_user == user
      return head(:forbidden)
    end

    user.advocates( complaint )

    render json: @complaint
  end

end
