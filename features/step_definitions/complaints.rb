Given /^'(.*)' was written by author$/ do |complaint_title|
  name = complaint_title.split( " " ).first
  author = User.create( :email => "#{name.downcase}@domain.com", 
    :password => "weakest_password",
    :password_confirmation => "weakest_password" 
  )
  Complaint.create( :title => complaint_title, :body => Faker::Lorem.sentences,
    :author => author );
end

When "User visit complaints" do
  visit( complaints_index_path )
end

Then "User sees '(.*)' and it's advocators" do |complaint_title|
end
