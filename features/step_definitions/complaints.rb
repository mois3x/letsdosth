def complaint_author_info(complaint_title = " " ) 
  name = complaint_title.split( " " ).first.downcase
  return { :name => name, :email => "#{name.downcase}@domain.com",
    :password => 'weakest_password' }
end

Given /^'(.*)' was written by the author$/ do |complaint_title|
  info = complaint_author_info(complaint_title)
  author = User.create( :email => info[:email], 
    :password => info[:password], 
    :password_confirmation => info[:password] 
  )
  Complaint.create( :title => complaint_title, :body => Faker::Lorem.sentences,
    :author => author );
end

When "User visit 'complaints index'" do
  visit( complaints_index_path )
end

Then /^User sees '(.*)' and it's advocators$/ do |complaint_title|
  info = complaint_author_info(complaint_title)
  author = User.where( email: info[:email] ).first
  complaint = Complaint.includes(:users).where( 
    "signatures.user_id = #{author.id}" ).first
 
  page.should have_content( complaint.body )
  page.should have_content( complaint.title )

  complaint.users(true).each do |u| 
    page.should have_content( u )
  end
end
