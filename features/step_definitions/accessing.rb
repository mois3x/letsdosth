
def normalize_action( action = '' )
  action.downcase!.sub!(' ', '_')
end

Given "There is not users" do
  expect(User.all).to eq([])
end

And /^'(.*)' clicked '(.*)'$/ do |name, action|
  visit( root_path )
  click_on( normalize_action(action) )
end

When /^'(.+)' sign up$/ do |name|
  fill_in( 'Email', :with => "#{name.downcase}@fenix.com" )
  fill_in( 'Password', :with => "weakest_password" )
  fill_in( 'Password confirmation', :with => "weakest_password" )
  click_on( 'Sign up' ) 
end

When /^'(.+)' are logged in$/ do |name|
  page.has_content?('Salir')
end
