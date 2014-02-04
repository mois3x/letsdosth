
def normalize_action( action = '' )
  action.downcase!.sub!(' ', '_')
end

Given /^'(.*)' is enrolled$/ do |name|
  User.create( :email => "#{name.downcase}@fenix.com", 
    :password => "weakest_password",
    :password_confirmation => "weakest_password" 
  )
end

Given "There is not users" do
  expect(User.all).to eq([])
end

And /^'(.*)' clicked '(.*)'$/ do |name, action|
  visit( root_path )
  click_on( normalize_action(action) )
end

And /^'(.*)' visit logging page$/ do |name| 
  visit( root_path )
  click_on('log_in')
end

And "There not user logged in" do
  visit( destroy_user_session_path )
end

When /^'(.+)' sign up$/ do |name|
  fill_in( 'Email', :with => "#{name.downcase}@fenix.com" )
  fill_in( 'Password', :with => "weakest_password" )
  fill_in( 'Password confirmation', :with => "weakest_password" )
  click_on( 'Sign up' ) 
end

When /^'(.+)' sign in$/ do |name|
  fill_in( 'Email', :with => "#{name.downcase}@fenix.com" )
  fill_in( 'Password', :with => "weakest_password" )
  click_on( 'Sign in' ) 
end

When /^'(.+)' are logged in$/ do |name|
  page.has_content?('Salir')
end
