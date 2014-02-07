class Complaint < ActiveRecord::Base
  attr_accessible :body, :title, :author

  validates :title, :body, :presence => true
  validates :author, :presence => true

  has_many :signatures
  has_many :users, :through => :signatures

  before_save do
    unless @author.nil? 
      self.signatures.new( :when => Date.today, :user => @author ) unless @author.nil?
    end
  end

  def author=( user ) 
    @author = user if self.users.empty?
  end

  def author
    self.users.first || @author
  end

end
