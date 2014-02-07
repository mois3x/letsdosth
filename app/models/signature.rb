class Signature < ActiveRecord::Base
  attr_accessible :when, :user

  belongs_to :user
  belongs_to :complaint
end
