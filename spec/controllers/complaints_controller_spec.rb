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
  end

  describe "#update" do
    context "complaint written by john" do
      describe "complaint with invalid data" do
        it "should not be updated" do
          expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
            .and_return(complaint_by_john)

          puts "HERE - #{complaint_by_john}"

            post :update, { :id => complaint_by_john.id, 
              :complaint => { :title => "" , :body => "new body" } }
          #expect {
          #}.to_not change { complaint_by_john.title }
          
          puts "THERE - #{complaint_by_john}"

          # expect(complaint_by_john.body).to eql("new body")
        end
      end
      describe "complaint with valid data" do
        it "should update complaint" do
          expect(Complaint).to receive(:find).with(complaint_by_john.id.to_s)
            .and_return(complaint_by_john)
          post :update, { :id => complaint_by_john.id, 
              :complaint => { :title => "new title", :body => "new body" } }
          expect(complaint_by_john.title).to eql("new title")
          expect(complaint_by_john.body).to eql("new body")
        end
      end
    end
  end
end
