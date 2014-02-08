class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :complaints, :through => :signatures
  has_many :signatures

  def advocates( complaint )
    complaint.signatures.create!( :when => Date.today, 
      :user => self)
  end

  def relinquishes( complaint )
    complaint.users.delete( self ) unless complaint.author == self
  end
end
