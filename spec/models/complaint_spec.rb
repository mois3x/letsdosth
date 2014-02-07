require 'spec_helper'

describe Complaint do
  let(:author) { User.create( :email => 'user00@domain.com', 
      :password => 'weak_pwd', :password_confirmation => 'weak_pwd' )  }

  describe "create" do
    it "shouldn't create a complaint without mandatorie fields" do
      c = Complaint.new
      c.should_not be_valid
    end

    it "should create a complaint signed by author" do
      c = Complaint.create( :author => author, 
                           :title => "Price raises", 
                           :body => "long body " * 512 )
      c.author.should eq(author)
    end

    it "should not be valid without an author" do
      c = Complaint.new( :title => "Price raises", :body => "body" )
      c.should_not be_valid
    end

  end

  describe "author" do
    before do
      Complaint.create( :author => author, 
        :title => "Price raises", :body => "long body " * 512 )
    end

    it "should grab the right author" do
      c = Complaint.first 
      c.should_not be(nil)
      c.author.should eq(author)  
    end
  end

end

