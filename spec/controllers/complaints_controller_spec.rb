require 'spec_helper'

describe ComplaintsController do
  let (:john) { Factory::UserFactory.user } 
  let!(:complaint_by_john) { Factory::UserComplaint.complaint( john ) }
  let (:chad)   { Factory::UserFactory.user( 'chad' ) }
  let!(:complaint_by_chad) { Factory::UserComplaint.complaint( chad ) }

  before do
    @controller.stub(:current_user).and_return(john)
  end

  describe "#index" do
    it "should call" do 
      expect(Complaint).to receive(:all)
      expect(response.status).to eql(200)
      get :index
    end
  end

  describe "#new" do
    it "should call" do 
      expect(Complaint).to receive(:new)
      expect(response.status).to eql(200)
      get :new
    end
  end
  
  describe "#edit" do
    context "complaint written by john" do
      it "should be found" do
        expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
          .and_return(complaint_by_john)
        get :edit, id: complaint_by_john.id
        expect(response.status).to eql(200)
      end
    end

    context "complaint written by chad" do
      it "should be prevented from being edited" do
        expect(Complaint).to receive(:find).with(complaint_by_chad.id.to_s)
          .and_return(complaint_by_chad)
        get :edit, id: complaint_by_chad.id
        expect(response.status).to eql(403)
      end
    end

=begin
    describe "complaint by john user" do
      
      it "should update complaint fields" do
        puts "#{ complaint_by_john.inspect() } - #{ complaint_by_john } "
        expect(response.status).to eql(200)
        post :update, 
          { :id => complaint_by_john.id,
            :complaint => { 
              :title => 'title modified',
              :body => 'body modified' 
            }
          }
        puts "#{ complaint_by_john.inspect() } - #{ complaint_by_john } "
        complaint_by_john.title.should eql('title modified')
        complaint_by_john.body.should  eql('body modified')
      end

    end

  end

  describe "create a new complaint" do

    describe "whole data are provided" do 
      it "should create a new complaint" do
        expect {
          post :create, :complaint => { :title => 'a title', :body => 'a body' }
          response.should redirect_to '/complaints'
        }.to change {
          Complaint.all.size
        }.by(1)

      end
    end

    describe "some data are missed" do
      it "should not create a new complaint" do
        expect {
          post :create, :complaint => { :title => 'a title' }    
        }.not_to change { 
          Complaint.all.size
        }
      end
    end
    
=end
  end
end
