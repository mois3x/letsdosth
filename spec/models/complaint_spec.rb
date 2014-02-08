require 'spec_helper'

describe Complaint do
  let(:author) { User.create( :email => 'author0@domain.com', 
      :password => 'weak_pwd', :password_confirmation => 'weak_pwd' )  }
  let(:john) { User.create( :email => 'john@domain.com', 
      :password => 'weak_pwd', :password_confirmation => 'weak_pwd' )  }
  let(:chad) { User.create( :email => 'chad@domain.com', 
      :password => 'weak_pwd', :password_confirmation => 'weak_pwd' )  }
  let(:complaint) {
    Complaint.create( :author => author, :title => "Price raises", 
      :body => "long body " * 512 ) }
  let(:ignored_agreement) {
    complaint = Complaint.create( :author => author, 
      :title => "Companies ignored the agreement", :body => "long description" ) 
    chad.advocates( complaint )
    john.advocates( complaint )
    complaint
  }
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
      Complaint.create( :author => author, :title => "Price raises", 
        :body => "long body " * 512 )
    end

    it "should grab the right author" do
      c = Complaint.first 
      c.should_not be(nil)
      c.author.should eq(author)  
    end
  end

  describe "user advocates the complaint" do
    it "advocator and author should belong the complaint" do
      john.advocates( complaint )
      complaint.users(true).should include( john, author )
      complaint.users(true).should_not include( chad )
      complaint.author.should eq(author)
    end
  end

  describe "user relinquishes the complaint" do
    it "should not belong to the advocators list" do
      ignored_agreement.users(true).should include( john, chad, author )
      chad.relinquishes( ignored_agreement )
      complaint.users(true).should_not include( chad )
      ignored_agreement.users(true).should include( john, author )
    end
  end

  describe "author relinquishe a complaint" do
    it "should not be posible for author relinquishe a complaint" do
      ignored_agreement.author.should eq( author )
      author.relinquishes( ignored_agreement )
      ignored_agreement.author.should eq( author )
      ignored_agreement.users(true).should include( john, author )
    end
    pending "author should be able to relinquishe a complaint"
  end


end

