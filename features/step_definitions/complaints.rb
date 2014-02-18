
Given /^'(.*)' was written$/ do |complaint_title|
  author = User.where( :email => grab_email_from( complaint_title ) ).first
  c = Complaint.create!( :title => complaint_title, :body => Faker::Lorem.sentences,
    :author => author );

  # Users advocate the complaint
  self.create_advocators.each do |u|
    u.advocates( c )    
  end
end

When "User visits 'complaints'" do 
  visit( complaints_path )
end

Then /^User sees '(.*)' complaints and it's advocators$/ do |complaint_title|
  author = User.where( :email => self.grab_email_from(complaint_title) ).first
  Complaint.by_author( author ).each do |complaint|
  page.should have_content( complaint.body )
  page.should have_content( complaint.title )

  complaint.advocators.each do |u| 
    page.should have_content( u.email )
  end
end
end

Then /^'(.*)' sees the complaint titled '(.*)'$/ do |name, title|
  page.should have_content( title )
  page.should have_content( "Body of my #{title}" )
end

Given /^'(.*)' visits new complaint page$/ do |name|
  visit( new_complaint_path ) 
end

When /^'(.*)' writes the '(.*)'$/ do |author, complain_title|
  fill_in( 'Title', :with => complain_title )
  fill_in( 'Body', :with => "Body of my #{complain_title}")
  click_on( 'Create' ) 
end

