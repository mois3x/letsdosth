module ComplaintModule
  def password
    "weakest_password"
  end

  def create_user
    User.create!( :email => Faker::Internet.email,
      :password => password, :password_confirmation => password )
  end

  def create_user_from( complaint_title )
    name = complaint_title.split( " " ).first.downcase
    User.create!( :email => "#{name.downcase}@domain.com",
      :password => password, :password_confirmation => password )
  end

  def create_advocators( howmany = 5 )
    result = []

    (1..howmany).each do 
      result << self.create_user
    end

    result
  end

  def grab_email_from( complaint_title )
    name = complaint_title.split( " " ).first.downcase
    "#{name.downcase}@domain.com"
  end
end

World( ComplaintModule )

Given /^'(.*)' was written$/ do |complaint_title|
  author = self.create_user_from( complaint_title )
  c = Complaint.create!( :title => complaint_title, :body => Faker::Lorem.sentences,
    :author => author );

  # Users advocate the complaint
  self.create_advocators.each do |u|
    u.advocates( c )    
  end
end

When "User visit 'complaints index'" do
  visit( complaints_index_path )
end

Then /^User sees '(.*)' and it's advocators$/ do |complaint_title|
  author = User.where( :email => self.grab_email_from(complaint_title) ).first
  complaint = Complaint.includes(:users).where( 
    "signatures.user_id = #{author.id}" ).first
 
  page.should have_content( complaint.body )
  page.should have_content( complaint.title )

  complaint.advocators.each do |u| 
    page.should have_content( u.email )
  end
end
