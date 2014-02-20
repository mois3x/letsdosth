require 'spec_helper'

describe ComplaintsController do
  let (:current) { Factory::UserFactory.user } 

  before do
    @controller.stub(:current_user).and_return(current)
  end

  describe "index" do
    it "should call" do 
      Complaint.should_receive(:all)
      get :index
    end
  end

  describe "new" do
    it "should call" do 
      Complaint.should_receive(:new)
      get :new
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
    
  end


=begin
  describe "creating complaint without title or without body" do
    it "should redirect to complaint new page" do
      visit new_complaint_path

      debugger
      puts page
      debugger

    end
  end
=end
end
